require 'rspec'
require 'method_missing'

describe 'method_missing' do

  it 'El chino no entiende saludar' do
    chino = Chino.new
    expect{chino.saludar}.to raise_error(NoMethodError)
  end

  it 'Ahora el chino cuando no entiende algo dice "no entendo"' do
    chino = Chino.new
    expect(chino.saludar).to eq("no entendo")
  end

  it 'Pero ahora el chino no entiende nada a excepcion de salulal' do
    chino = Chino.new
    expect(chino.asdfa).to eq("no entendo")
  end

  it 'Solo quiero que el chino responda que no entiende cuando el inspector pregunta algo' do
    chino = Chino.new
    expect(chino.inspector_pregunta_si_apaga_la_heladera_de_noche).to eq("no entendo")
  end

  it 'Que pasa si le mando otro mensaje ahora?' do
    #en vez de no entendo -> null
    chino = Chino.new
    expect(chino.hola).to eq("no entendo")

  end

  it 'Como hago que lanze la excepcion de nuevo?' do
    #se agrega super a method_missing
    chino = Chino.new
    expect{chino.hola}.to raise_error(NoMethodError)
  end

  #preguntas, dudas?

  it 'Que pasa si le pregunto al chino si sabe respoder a salulal?' do
    chino = Chino.new
    expect(chino.respond_to?(:salulal)).to eq(true)
  end

  it 'Que pasa si le pregunto al chino si sabe respoder a inspector_pregunta_que_hora_es?' do
    chino = Chino.new
    #esto falla porque no esta re-definido respond_to?
    expect(chino.respond_to?(:inspector_pregunta_que_hora_es)).to eq(false)
  end

  it 'puedo hacer que el test anterior pase?' do
    #redifino respond_to?
    chino = Chino.new
    expect(chino.respond_to?(:inspector_pregunta_si_apaga_la_heladera_de_noche)).to eq(true)
  end

  it 'veamos que sabe responder a == (xq tiene que buscar en la jerarquia)' do
    #redifino respond_to?
    chino = Chino.new
    expect(chino.respond_to?(:==)).to eq(true)
  end

  it 'Que pasa si le pido el method salulal?' do
    chino = Chino.new
    expect(chino.method(:salulal).name).to eq(:salulal)
  end

  it 'Que pasa si le pido el method inspector_pregunta...?' do
    chino = Chino.new
    expect(chino.method(:inspector_pregunta_si_apaga_la_heladera_de_noche)).to eq(Method)
    #undefined method `inspector_pregunta_si_apaga_la_heladera_de_noche' for class `Chino'
  end

  it 'Que pasa si desde method_missing llamo a otro metodo no definido????chan!' do
    chino = Chino.new
    expect(chino.arigato(2)).to raise_error(SystemStackError)

  end
  
  # que pasa si la super clase define un metodo?
  


  #En que caso puedo usar esto.
  it 'Ahora al chino le mando el mensaje que no entiende pero la respuesta es personalizada' do
    #comparar con el caso por defecto
    chino = Chino.new
    expect{chino.arigato(2)}.to raise_error(NoMethodError, "El siguiente mensaje: arigato con argumentos: [2], no esta implementado")

  end

  it 'Lo puedo usar para que haya una implementacion por defecto' do
    enemigo = Enemigo.new

    enemigo.daño_por_hielo

    expect(enemigo.vida).to eq(99)
  end

  #esto hacerlo antes
  it 'que pasa si la super clase tiene defino del metodo?' do
    enemigo = EnemigoDeHielo.new

    enemigo.daño_por_hielo
    una_clase = Class.new
    puts "here"
    puts una_clase.method(:method_missing).owner

    expect(enemigo.vida).to eq(98)
  end
  
  #se puede delegar la responsabilidad a otro objeto tipo guerrero.new(defenza)

  #como creen que funciona?
  #mini explicacion -> el metodo que falta se busca en toda la jerarquia hasta llegar a basicObject
  # Si ahi no encuentra implementacion entonces hace una nueva busqueda con method_missing como selector
  # O sea se ejecuta el metodo look-up 2 veces.









end
