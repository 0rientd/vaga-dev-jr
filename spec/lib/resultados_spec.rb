require 'rails_helper'
require 'resultados'

RSpec.describe Resultados, type: :lib do
  describe "Calcula performance" do
    it "com atributos validos" do
      resultado = Resultados.new
      resultado.valor_meta = 10
      resultado.valor_realizado = 20

      expect(resultado.calcula_performance).to eq(2.0)
    end

    it "com valor realizado valido e meta zero" do
      resultado = Resultados.new
      resultado.valor_meta = 0
      resultado.valor_realizado = 20

      expect(resultado.calcula_performance).to eq(nil)
    end

    it "com valor realizado valido e meta null" do
      resultado = Resultados.new
      resultado.valor_meta = nil
      resultado.valor_realizado = 20

      expect(resultado.calcula_performance).to eq(0.0)
    end

    it "com valor meta valido e realizado zero" do
      resultado = Resultados.new
      resultado.valor_meta = 10
      resultado.valor_realizado = 0

      expect(resultado.calcula_performance).to eq(1)
    end
  end

  describe "Calcular realizado" do
    it "com valor realizado valido" do
    resultado = Resultados.new
      resultado.valor_performance = 0
      resultado.valor_meta = 0
      resultado.valor_realizado = 1

      expect(resultado.calcula_realizado).to eq(1)
    end
  end

  describe "Verificar parâmetros no calcula performance" do
    it "com valor_realizado recebendo caracter" do 
      resultado = Resultados.new
      resultado.valor_meta = 0
      resultado.valor_realizado = "f"

      expect(resultado.calcula_performance).to eq(nil)
    end

    it "com valor_meta recebendo 0 e valor_realizado 0" do
      resultado = Resultados.new
      resultado.valor_meta = 0
      resultado.valor_realizado = 0

      expect(resultado.calcula_performance).to eq(nil)
    end
  end
end
