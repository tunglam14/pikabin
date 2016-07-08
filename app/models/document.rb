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
    # TODO: use an other decryptor
    content_decrypted = Base64.decode64(self.content)
    return content_decrypted.gsub(@password, '')
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
    # TODO: use an other encryptor
    @password = SecureRandom.base64
    self.content = Base64.encode64(self.content + @password)
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

  # '0'  => 'After reading',
  # '-1'  => 'No expire',
  # '1m' => '1 min',
  # '5m' => '5 min',
  # '1h' => '1 hour',
  # '1d' => '1 day'
  def _get_datetime_from_duration_string
    case self.expired_at
    when 0, '0'
      return 0
    when '1m'
      return Time.now + 1.minutes
    when '-1'
      return -1
    when '5m'
      return Time.now + 5.minutes
    when '1h'
      return Time.now + 1.hours
    when '1d'
      return Time.now + 1.days
    else
      return 0
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
