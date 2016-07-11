class TokenService
  def self.build(friendly_id:, password:)
    "#{friendly_id}#{password}"
  end

  def self.extract(token:)
    begin
      friendly_id = token[0..4]
      password    = token[5..-1]
    rescue Exception => e
      friendly_id, password = nil
    end

    return {
      friendly_id: friendly_id,
      password: password
    }
  end
end
