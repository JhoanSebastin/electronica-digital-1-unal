#filename: Makefile
# Identificador v para representar los archivos verilog
v=
# Identificador top para representar el top del RTL a visualizar
top=
tb=
rtl:
	# 1. Síntesis del diseño, si la sintaxis es correcta, se genera un archivo json que representa el diseño
	yosys -p 'read_verilog $v; prep -top $(top); hierarchy -check; proc; write_json $(top).json'
	# 2. Comando para generación del RTL en formato SVG (vectorial)
	netlistsvg $(top).json -o $(top).svg
	# 3. Visualizar el RTL con el visor de imagenes eog
	eog $(top).svg
	# Identificador tb para el archivo verilog que contiene el testbench
sim:
	# 1. Crear el archivo .vvp ejecutable desde iverilog
	iverilog -o $(tb).vvp $(tb)
	# 2. Ejecuta el archivo .vvp para mostrar resultados
	vvp $(tb).vvp
