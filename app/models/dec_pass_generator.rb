class DecPassGenerator
  def initialize(string, key, secret)
    @string = string
    @key = key
    @secret = secret
  end

  def generate_decrypted_data
    decrypt(@string, @key, @secret)
  end

  ALGO = 'AES-128-CBC'

  private

  def decrypt(encrypted_string, consumer_key, consumer_secret)
    require 'openssl'
    require 'base64'

    cipher, iv = encrypted_string.split('--').map { |s| Base64.strict_decode64(s) }
    secret = OpenSSL::PKCS5.pbkdf2_hmac_sha1(consumer_secret, consumer_key, 1024, 128)
    aes = OpenSSL::Cipher::Cipher.new(ALGO)
    aes.decrypt
    aes.key = secret
    aes.iv = iv

    decrypted_data = aes.update(cipher)
    decrypted_data << aes.final
  end
end

