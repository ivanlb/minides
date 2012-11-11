# APPUNTI:

# UNICODE: enorme set di caratteri che ingloba praticamente tutti i caratteri necessari a tutte le lingue del mondo,
# il problema è che per parte di essi necessita di più di 8 bit per rappresentarli
# UTF-8: encoding che mappa i caratteri Unicode cambiando il loro encoding originale (potenzialmente superiore a 8 bit) in
# un encoding che per i caratteri che necessitano di più di 8 bit fa uso di più byte (octet), da 1 a 4 per la precisione.
#  da wikipedia:
# UTF-8 encodes each of the 1,112,064 code points in the Unicode character set using one to four 8-bit bytes
# (termed “octets” in the Unicode Standard)

# convertire intero in binario 12 bit: "%012b" % 7   => "000000000111"
# convertire stringa in codifica UTF-8 'stringa'.force_encoding('utf-8')
# convertire stringa (si suppone sia codificata in UTF-8) in array di interi rappresentanti i numerical HTML encoding of the Unicode character:
#   'stringa'.unpack('U*') NON SPLITTA NEGLI OCTET MA RESTITUISCE L'UNICO NUMERO DECIMALE DELL'ENCODING UNICODE
# convertire stringa (si suppone sia codificata in UTF-8) in enumerator di interi rappresentanti i caratteri UTF-8:
#   'stringa'.unpack('C*') CONVERTE NELLE OTTETTE DELL'UTF-8 ENCODING RAPPRESENTATE IN DECIMALE

require File.join(File.dirname(__FILE__), *%w[ key ])
require File.join(File.dirname(__FILE__), *%w[ round ])
require File.join(File.dirname(__FILE__), *%w[ bitwise_array ])

class Encrypter
  include BitwiseArray

  def encrypt(message, key)
    validate_message_format(message)
    validate_key_format(key)

    ary_message = ary_str_to_ary_int(message.split(//))
    ary_key = ary_str_to_ary_int(key.split(//))

    k = Key.new(ary_key)
    1.upto 4 do |i|
      k_i = k.calculate(i)
      round = Round.new(ary_message, k_i)
      ary_message = round.calculate
    end

    return ary_message.join
  end

  def decrypt(cyphertext, key)
    validate_message_format(cyphertext)
    validate_key_format(key)

    ary_message = ary_str_to_ary_int(cyphertext.split(//))
    ary_message = invert_12_bits_array(ary_message)

    ary_key = ary_str_to_ary_int(key.split(//))

    k = Key.new(ary_key)
    4.downto 1 do |i|
      k_i = k.calculate(i)
      round = Round.new(ary_message, k_i)
      ary_message = round.calculate
    end

    return invert_12_bits_array(ary_message).join
  end

  private

  def validate_message_format(message)
    validate_format(message, "Message")
  end

  def validate_key_format(key)
    validate_format(key, "Key")
  end

  def validate_format(bit_string, token)
    if not bit_string.class == String
      raise RuntimeError, "#{token} is not a string"
    end
    if not bit_string.match(/^(0|1)+$/)
      raise RuntimeError, "#{token} is not a bit string"
    end
  end

  def invert_12_bits_array(array)
    left_right_inverted = []
    left_right_inverted[0..5] = array[6..11]
    left_right_inverted[6..11] = array[0..5]
    return left_right_inverted
  end
end
