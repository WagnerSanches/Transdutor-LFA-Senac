class ADF
  def initialize(cadeia)
    @cadeia = cadeia
    @indice = 0
    @max = cadeia.size 
    @value = 0
  end

  def proximo
    @indice == @max ? "" : @cadeia[@indice]
  end

  def iniciar
    estado = "q0"

    case [proximo, estado]
    in ["I" | "V", "q0"]
      estado = "q1_u"
    in ["X" | "L", "q0"]
      estado = "q2_d"
    in ["C" | "D", "q0"]
      estado = "q3_c"
    in ["M", "q0"]
      estado = "q4_m"
    else
      puts "Valor vazio ou invalido!"
    end

    loop do
      case [estado]
      in ["q1_u"]
        estado = unidade(estado)
      in ["q2_d"]
        estado = dezena(estado)
      in ["q3_c"]
        estado = centena(estado)
      in ["q4_m"]
        estado = unidade_milhar(estado)
      in [""]
        puts "Aceito 😀 \nValor: #{@value}"
        break
      else
        puts "Rejeitado 😞"
        break
      end
      @indice += 1
    end
  end

  def unidade(estado)
    loop do
      case [proximo, estado]
      in ["I", "q1_u"]
        @value += 1
        estado = "q1_I"
      in ["I", "q1_I"]
        @value += 1
        estado = "q1_II"
      in ["I", "q1_II"]
        @value += 1
        estado = "q1_III"
      in ["V", "q1_I"]
        @value += 3
        break
      in ["V", "q1_u"]
        @value += 5
        estado = "q1_V"
      in ["I", "q1_V"]
        @value += 1
        estado = "q1_VI"
      in ["X", "q1_I"]
        @value += 8
        break
      in ["", _]
        break
      else
        return "err"
      end
      @indice += 1
    end
    ""
  end

  def dezena(estado)
    loop do
      case [proximo, estado]
      in ["X", "q2_d"]
        @value += 10
        estado = "q2_X"
      in ["X", "q2_X"]
        @value += 10
        estado = "q2_XX"
      in ["L", "q2_X"]
        @value += 30
        break
      in ["L", "q2_d"]
        @value += 50
        estado = "q2_L"
      in ["C", "q2_X"]
        @value += 80
        break
      in ["I" | "V", _]
        unidade("q1_u")
        break
      in ["", _]
        break
      else
        return "err"
      end
      @indice += 1
    end
    ""
  end

  def centena(estado)
    loop do
      case [proximo, estado]
      in ["C", "q3_c"]
        @value += 100
        estado = "q3_C"
      in ["C", "q3_C"]
        @value += 100
        estado = "q3_CC"
      in ["D", "q3_C"]
        @value += 300
        break
      in ["D", "q3_c"]
        @value += 500
        estado = "q3_D"
      in ["M", "q3_C"]
        @value += 800
        break
      in ["X" | "L", _]
        dezena("q2_d")
        break
      in ["I" | "V", _]
        unidade("q1_u")
        break
      in ["", _]
        break
      else
        return "err"
      end
      @indice += 1
    end
    ""
  end

  def unidade_milhar(estado)
    loop do
      case [proximo, estado]
      in ["M", "q4_m"]
        @value += 1000
        estado = "q4_M"
      in ["M", "q4_M"]
        @value += 1000
        estado = "q4_MM"
      in ["M", "q4_MM"]
        @value += 1000
        estado = "q4_MMM"
      in ["C" | "D", _]
        centena("q3_c")
        break
      in ["X" | "L", _]
        dezena("q2_d")
        break
      in ["I" | "V", _]
        unidade("q1_u")
        break
      in ["", _]
        break
      else
        return "err"
      end
      @indice += 1
    end
    ""
  end
end

adf = ADF.new("MMCCXXII")
adf.iniciar