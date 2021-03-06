=begin
  Problema: http://dojopuzzles.com/problemas/exibe/intervalos/

  Dado uma lista de números inteiros, agrupe a lista em um conjunto de intervalos
  Exemplo:
  Entrada: 100, 101, 102, 103, 104, 105, 110, 111, 113, 114, 115, 150
  Saída: ["100-105"], ["110-111"], ["113-115"], ["150"]
  
  Alberto Leal - albertoleal.eti.br
=end

require 'set'

class Intervalo
  attr_reader :valores
  
  def initialize(*valores)
    @valores = SortedSet.new(valores.flatten)
  end
  
  def agrupados
    valores_em_lista = gerar_sublistas

    saida = ""
    valores_em_lista.each do |lista|
      primeiro_elemento = lista.first
      ultimo_elemento   = lista.last

      retorno = "#{primeiro_elemento}"
      retorno << "-#{ultimo_elemento}" unless primeiro_elemento.eql? ultimo_elemento

      saida << "[#{retorno}], "
    end
    
    saida[0..-3]
  end
  
  private
  def gerar_sublistas
    sub_listas = @valores.inject([[]]) do |result, element|
      ultimo_grupo    = result.last
      ultimo_elemento = ultimo_grupo.last

      if ultimo_elemento.nil? || ultimo_elemento == element -1
        ultimo_grupo << element
      else
        result << [element]
      end

      result
    end
    
    sub_listas
  end
end

if $0 == __FILE__
  require 'test/unit'
  
  class IntervalosTest < Test::Unit::TestCase

    def test_lista_vazia
      valores = Intervalo.new
      assert_equal "[]", valores.agrupados
    end

    def test_numero_unico
      valores = Intervalo.new(100)
      assert_equal "[100]", valores.agrupados
    end
    
    def test_3_numeros_iguais
      valores = Intervalo.new(100, 100, 100)
      assert_equal "[100]", valores.agrupados
      
      valores = Intervalo.new([100, 100, 100])
      assert_equal "[100]", valores.agrupados
    end
    
    def test_valores_agrupados 
      valores = Intervalo.new(100, 101, 102, 105)
      assert_equal "[100-102], [105]", valores.agrupados
    end

    def test_valores_agrupados_final 
      valores = Intervalo.new(100, 101, 102, 103, 104, 105, 110, 111, 113, 114, 115, 150)
      assert_equal "[100-105], [110-111], [113-115], [150]", valores.agrupados
    end

  end
end