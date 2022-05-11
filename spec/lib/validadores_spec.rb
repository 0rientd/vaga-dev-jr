require 'rails_helper'
require 'validadores'

RSpec.describe Validadores, type: :lib do
  describe "Validadores" do
    context "data" do
      it "validador data (YYYY-MM-DD)" do
        data = Validadores.data('2019-12-31')

        expect(data).to eq(true)
      end

      it "validador data (YYYY-MM)" do
        data = Validadores.data_ano_mes('2022-05')
        expect(data).to eq(true)

        data = Validadores.data_ano_mes('3000-13')
        expect(data).to eq(false)
      end

      it "validador para data (DD/MM/YYYY)" do
        data = Validadores.data_com_barra('10/05/2022')
        expect(data).to eq(true)

        data = Validadores.data_com_barra('31/12/2022')
        expect(data).to eq(true)

        data = Validadores.data_com_barra('31/01/2500')
        expect(data).to eq(true)

        data = Validadores.data_com_barra('01/10/2022')
        expect(data).to eq(true)

        data = Validadores.data_com_barra('22/10/2022')
        expect(data).to eq(true)

        data = Validadores.data_com_barra('35/10/2022')
        expect(data).to eq(false)

        data = Validadores.data_com_barra('00/15/3000')
        expect(data).to eq(false)

        data = Validadores.data_com_barra('04-10-2022')
        expect(data).to eq(false)

        data = Validadores.data_com_barra('04102022')
        expect(data).to eq(false)
      end
    end

    context "número" do
      it "validador número inteiro" do
        resultado = Validadores.valida_numero(1)
        
        expect(resultado).to eq('Integer')
      end

      it "validador número decimal" do
        resultado = Validadores.valida_numero(0.0)
        
        expect(resultado).to eq('Float')
      end

      it "validador número percentual" do
        skip("escreva testes para esses casos")
      end
    end

    context "diversos" do
      it "validador e-mail" do
        resultado = Validadores.email('carlos.henrique@0rientd.dev.br')
        expect(resultado).to eq(true)
      end
    end
  end
end
