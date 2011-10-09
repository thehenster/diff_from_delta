module DiffFromDelta
  
  def self.compile_diff_from_delta(text1, delta)
    diff_from_delta(text1, delta).delete_if{|d| d[0]==-1 }.map{|d| d[1] }.join("")
  end
  
  def self.diff_from_delta(text1, delta)
    diff_delete = -1
    diff_insert = 1
    diff_equal = 0
    diffs = []
    pointer = 0  # Cursor in text1
    tokens = delta.split("\t")
    for token in tokens
      if token == ""
        # Blank tokens are ok (from a trailing \t).
        next
      end
      # Each token begins with a one character parameter which specifies the
      # operation of this token (delete, insert, equality).
      param = token[1..-1]
      if token[0..0] == "+"
        param = URI.unescape(param)
        diffs << [diff_insert, param]
      elsif token[0..0] == "-" || token[0..0] == "="
        begin
          n = param.to_i
        rescue
          raise("Invalid number in diff_fromDelta: " + param)
        end
        if n < 0
          raise("Negative number in diff_fromDelta: " + param)
        end
        #text = text1[pointer : pointer + n]
        text = text1[pointer..pointer+(n-1)]
        pointer += n
        if token[0..0] == "="
          diffs << [diff_equal, text]
        else
          diffs << [diff_delete, text]
        end
      else
        # Anything else is an error.
        raise("Invalid diff operation in diff_fromDelta: #{token[0..0]}")
      end
    end # end for token in tokens
    if pointer != text1.length
      raise("Delta length (#{pointer}) does not equal source text length (#{text1.length}).")
    end
    return diffs

  end
  
end
