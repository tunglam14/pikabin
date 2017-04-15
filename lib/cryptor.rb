class Cryptor
  ALGORITHM = :symmetric

  attr_accessor :content,
                :encrypted_content,
                :decrypted_content,
                :password

  def initialize(content: nil, password: nil, encrypted_content: nil)
    @content = content
    @encrypted_content = encrypted_content
    @password = password || gen_random_password
  end

  def encrypt()
    @encrypted_content = @content.encrypt(ALGORITHM, :password => @password)
  end

  def decrypt()
    @decrypted_content = @encrypted_content.decrypt(ALGORITHM, :password => @password)
  end

  private
  def gen_random_password
    SecureRandom.hex[0..4]
  end
end
