class Document < ActiveRecord::Base
  before_save :encrypt_content
  before_save :set_friendly_id
  before_save :set_expired_at

  attr_accessor :password

  def self.find_and_validate_by_friendly_id(friendly_id)
    document = self.find_by(friendly_id: friendly_id)

    # not found
    if document.nil?
      return nil
    end

    # one time document or expired
    if document.is_expired?
      return process_expired(document)
    end

    return document
  end

  def content_decrypted
    encryption =Cryptor.new(encrypted_content: self.content, password: @password)
    return encryption.decrypt()
  end

  def is_expired?
    expire = self.expired_at

    case expire
    when "0", nil, 0
      # One time link
      return true

    when "-1", -1
      # immortal link
      return false

    else
      # check period
      expire = expire.to_datetime rescue false

      if not expire
        Rails.logger.error "Parse document expire fail"
        return true
      end

      if Time.now <= expire
        return false
      end

      if Time.now > expire
        return true
      end

      return true
    end
  end

  private
  def encrypt_content
    encryption =Cryptor.new(content: self.content)
    # This is random password from Cryptor
    @password = encryption.password
    self.content = encryption.encrypt()
  end

  def set_friendly_id
    self.friendly_id = _gen_unique_friendly_id
  end

  def set_expired_at
    self.expired_at = _get_datetime_from_duration_string
  end

  def _gen_unique_friendly_id
    all_doc = Document.all.as_json
    begin
      uniq_id = SecureRandom.uuid[0..4]
      is_id_exist = ((all_doc.select {|v| v['friendly_id'] == uniq_id}) != [])
    end while is_id_exist

    return uniq_id
  end

  def _get_datetime_from_duration_string
    case self.expired_at
    when 0, '0'
      return 0
    when '-1', -1
      return -1
    else
      return Time.now + self.expired_at.to_i.seconds
    end
  end

  # Cloning object and deteling expired doc
  def self.process_expired(document)
    # document_clone is not persistence data
    document_clone = document.clone
    Thread.new {
      document.destroy rescue Rails.logger.info "Delete document fail"
    }
    return document_clone
  end
end
