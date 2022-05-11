require 'rails_helper'
require 'csv'
require 'validadores'
require 'resultados'
require 'calculos'

include ActionDispatch::TestProcess::FixtureFile

RSpec.describe Validadores, type: :lib do
  describe "Importando arquivos" do
    let(:arquivo_valido) { { file: fixture_file_upload('arquivo_valido.csv', 'text/csv') } }
    let(:arquivo_invalido) { { file: fixture_file_upload('arquivo_invalido.csv', 'text/csv') } }

    context "Arquivo valido" do
      it "validando datas" do
        @file = File.open(arquivo_valido[:file])

        CSV.foreach(@file, {headers: true, header_converters: :symbol, col_sep: ';'}) do |row|
          break unless Validadores.data(row[:periodo])
          cliente = Cliente.create!(nome: row[:cliente])
          cliente.resultado.create!(periodo: row[:periodo], valor_meta: row[:valor_meta], valor_realizado: row[:valor_realizado])
        end

        expect(Cliente.all.size).to eq(3)
      end

      it "salva arquivo na base e calcula performance total" do
        resultados_esperados = [0.8333333333333334, 1.2, 4.0]
        count = 0
        @file = File.open(arquivo_valido[:file])

        CSV.foreach(@file, {headers: true, header_converters: :symbol, col_sep: ';'}) do |row|
          cliente = Cliente.create!(nome: row[:cliente])
          cliente.resultado.create!(periodo: row[:periodo], valor_meta: row[:valor_meta], valor_realizado: row[:valor_realizado])
          
          resultado = Calculos.performance(row[:valor_meta], row[:valor_realizado])
          expect(resultado).to eq(resultados_esperados[count])
          count = count + 1
        end
      end
    end

    context "Arquivo invalido" do
      it "validando datas" do
        @file = File.open(arquivo_invalido[:file])

        CSV.foreach(@file, {headers: true, header_converters: :symbol, col_sep: ';'}) do |row|
          break unless Validadores.data(row[:periodo])
          cliente = Cliente.create!(nome: row[:cliente])
          cliente.resultado.create!(periodo: row[:periodo], valor_meta: row[:valor_meta], valor_realizado: row[:valor_realizado])
        
          expect(Validadores.data(row[:periodo])).to eq(true)
          expect(Validadores.data_ano_mes(row[:periodo])).to eq(false)
          expect(Validadores.data_com_barra(row[:periodo])).to eq(false)
        end
      end

      it "inserindo linhas na base somente se arquivo valido" do
        @file = File.open(arquivo_invalido[:file])

        CSV.foreach(@file, {headers: true, header_converters: :symbol, col_sep: ';'}) do |row|
          break unless Validadores.data(row[:periodo])
          cliente = Cliente.create!(nome: row[:cliente])
          cliente.resultado.create!(periodo: row[:periodo], valor_meta: row[:valor_meta], valor_realizado: row[:valor_realizado])
        end
        
        expect(Cliente.all.size).not_to eq(3)
      end
    end
  end
end
