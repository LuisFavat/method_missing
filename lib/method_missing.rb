class Chino

  def initialize
    @hijos = 0
  end

  def hijos(un_cant)
    @hijos = un_cant
  end

  def cant_hijos
    @hijos
  end


  def salulal
    'ohoola'
  end


  private def method_missing(symbol, *args)
    
    if symbol.start_with?('inspector_pregunta')
      'no entendo'
    else
      mensaje = "El siguiente mensaje: #{symbol} con argumentos: #{args}, no esta implementado"
      raise NoMethodError, mensaje
    end
  end

  def respond_to?(symbol)
    if symbol.start_with?('inspector_pregunta')
      return true
    end
    super
  end



end


class Enemigo

  attr :vida

  def initialize
    @vida = 100
  end



  private def method_missing(symbol, *args)
    if(symbol.start_with?("daño_por_"))
      @vida -= 1
    else
      super(symbol, *args)
    end

  end

end


class EnemigoDeHielo < Enemigo

  attr :vida

  def initialize
    @vida = 100
  end

  def daño_por_fuego
    @vida -= 10
  end

  def daño_por_tierra
    @vida -= 5
  end

  def daño_por_hielo
    @vida -= 2
  end
end
