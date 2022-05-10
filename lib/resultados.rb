class Resultados
  attr_accessor :valor_meta, :valor_realizado, :valor_performance

  def initialize()
    @valor_meta = valor_meta
    @valor_realizado = valor_realizado
    @valor_performance = valor_performance
  end

  def calcula_performance
    case valor_meta
    when nil
      return 0.0
    
    when 0
      return nil
    
    else
      return 1 if valor_realizado.zero?

    end

    valor_realizado / valor_meta
  end

  def calcula_realizado
    if valor_performance == 0
      return 1

    elsif valor_realizado.zero?
      return 0

    else
      valor_meta * valor_performance

    end
  end
end
