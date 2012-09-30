require File.join(File.dirname(__FILE__), *%w[.. src encrypter])

describe Encrypter do

  it "encrypts 12 bits message" do
    message = "110001000111"
    key = "001001101"
    encrypter = Encrypter.new
    cyphertext = encrypter.encrypt(message, key)

    cyphertext.should == '000011100101'
  end

  it "decrypts 12 bits message" do
    message = "000011100101"
    key = "001001101"
    encrypter = Encrypter.new
    plaintext = encrypter.decrypt(message, key)

    plaintext.should == '110001000111'
  end

  it "raises an error if message or key are not bit string" do
    encrypter = Encrypter.new
    lambda { encrypter.encrypt(123, "101")   }.should raise_error
    lambda { encrypter.encrypt("123", "101") }.should raise_error
    lambda { encrypter.encrypt("101", 101)   }.should raise_error
    lambda { encrypter.encrypt("101", "1a1") }.should raise_error
  end

end
