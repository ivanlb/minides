module BitwiseArray

  def xor(array_a, array_b)
    if  array_a.size != array_b.size
      raise ArraySizeMismatchException.new(array_a, array_b),
        "Arrays size mismatch: #{array_a.size} not equals #{array_b.size}"
        end

    xored = []
    for i in 0...array_a.size
      xored[i] = array_a[i] ^ array_b[i]
    end

    return xored
  end

  def validate_string_ary(ary)
    if ary.class != Array or ary[0].class != String or (ary[0] != "0" and ary[0] != "1")
      raise RuntimeError, "#{ary}, isn't an array of '0','1' String, first element is #{ary[0].class}"
    end
    return true
  end

  def validate_int_ary(ary)
    if ary.class != Array or ary[0].class != Fixnum or (ary[0] != 0 and ary[0] != 1)
      raise RuntimeError, "#{ary} isn't an array of 0,1 Fixnum, first element is #{ary[0].class}"
    end
    return true
  end

  def ary_str_to_ary_int(array_str)
    validate_string_ary(array_str)
    array_int = []
    array_str.each_index { |i, e| array_int[i] = array_str[i].to_i }
    return array_int
  end

  class ArraySizeMismatchException < RuntimeError
    attr_reader :round
    def initialize(array_a, array_b)
      @array_a = array_a
      @array_b  =array_b
    end
  end

end
