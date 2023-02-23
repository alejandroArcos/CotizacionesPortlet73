
var base = "/group/portal-agentes";
var paginaFamiliar = "/empresarial";
var paginaEmpresarial = "/casa-habitacion";
var familiar = "Familiar";
var empresarial = "Empresarial";

/*
 * ******************Funcionalidad para
 * paginado**********************************
 */

/**
 * Observacion: para los valores del htm a remplazar hay q poner ¿?
 * 
 * @param {string}
 *            formularioSerializable - Selector formato jquery para el
 *            formulario que se envia serializado ("#foo\\.bar")
 * @param {string}
 *            url - direccion del servicio MVCResourceCommand a consumir
 * @param {string}
 *            selectorTabla - Selector formato jquery tabla afectada
 * @param {json}
 *            listadoColumnasJson - Arreglo json con los campos: nombre
 *            {string}, tipo {int}, --> tipos: 0 = cadena, 1 = fecha, 2 = moneda
 *            sin decimales, 3 = moneda con decimales, 4 = numerico, 5 =
 *            numerico con decimales
 * @param {string}
 *            nomListaRecorrer - nombre del objeto json donde esta contenida la
 *            lista a recorrer
 * @param {json}
 *            btnJson - Campos : requerido {bool}, html {string}, listaRemplazo
 *            {string[]}
 * @returns
 */
function customGeneraTablas(formularioSerializable, url, selectorTabla, listadoColumnasJson, nomListaRecorrer, btnJson) {
	showLoader();
	var copiaTabla = $( selectorTabla ).dataTable().api();
	var paginaSeleccionada = copiaTabla.page();
	var rowNum = copiaTabla.page.info().recordsTotal;
	if ((!valIsNullOrEmpty( paginaSeleccionada )) && (paginaSeleccionada > 0)) {
		/**
		 * ************* recordar que el row num hay que recibirlo en el
		 * resource comand*****************
		 */
		$.post(url,($( formularioSerializable ).serialize() + "&rowNum=" + rowNum),
			function(data) {
				if (data.code == 0) {
					var listaJson = eval( 'data.' + nomListaRecorrer );
					if (listaJson.length > 0) {
						$( selectorTabla ).dataTable().fnDestroy();
						$.each(listaJson, function(key, registro) {
							var fila = "<tr>";
							for (var i = 0; i < listadoColumnasJson.length; i++) {
								fila += "<td " + listadoColumnasJson[i].attrCelda + ">";
								fila += tipoValor( listadoColumnasJson[i].tipo,
										eval( 'registro.' + listadoColumnasJson[i].nombre ) );
								fila += "</td>";
							}
							if (btnJson.requerido) {
								var textoBoton = "<div class=\"actions-container dropleft\">"
										+ "<button type=\"button\" class=\"btn btn-outline-pink dropdown-menu-right px-3 py-2 waves-effect waves-light\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">"
										+ "<i class=\"fa fa-ellipsis-v\" aria-hidden=\"true\"></i>"
										+ "</button>"
										+ "<div class=\"dropdown-menu animated fadeIn\" >";

								if (registro.estado == "COTIZADO" && registro.modo == "MANUAL") {
									textoBoton += '<a class="dropdown-item" onclick="submitTmx( \''
											+ $( "#solicitarTmxURL" ).val()
											+ '\','
											+ registro.cotizacion
											+ ','
											+ registro.version
											+ ');" > <i class="fas fa-print mr-2"></i><span>  Solicitar Emisión  </span></a>';
								}

								if (registro.estado == "COTIZADO" || registro.estado == "SE NECESITAN MÁS DATOS") {
									if (registro.idProducto == 209) {
										textoBoton += '<a class="dropdown-item" href="/group/portal-agentes/empresarial?folioEmpresarial='
												+ registro.folio
												+ '&cotizacionEmpresarial='
												+ registro.cotizacion
												+ '&versionEmpresarial='
												+ registro.version
												+ '&modoEmpresarial=3"><i class="fas fa-print mr-2"></i><span>  Solicitar emisión  </span></a>';

									}	else if (registro.idProducto == 210) {
										textoBoton += '<a class="dropdown-item" href="/group/portal-agentes/empresarial?folioEmpresarial='
												+ registro.folio
												+ '&cotizacionEmpresarial='
												+ registro.cotizacion
												+ '&versionEmpresarial='
												+ registro.version
												+ '&modoEmpresarial=3"><i class="fas fa-print mr-2"></i><span>  Solicitar emisión  </span></a>';
									}	else {
										textoBoton += '<a class="dropdown-item" href="/group/portal-agentes/casa-habitacion?folioFamiliar='
												+ registro.folio
												+ '&cotizacionFamiliar='
												+ registro.cotizacion
												+ '&versionFamiliar='
												+ registro.version
												+ '&modoFamiliar=3"><i class="fas fa-print mr-2"></i><span> Solicitar emisión </span></a>';
									}

								}
								if (registro.estado == "COTIZADO"
										&& registro.modo == "MANUAL") {
									textoBoton += '<a class="dropdown-item" data-toggle="modal" href="#modal-revire" onclick="revireModal(\''
											+ $( "#revireURL" ).val()
											+ '\',\''
											+ registro.cotizacion
											+ ' \',\''
											+ registro.version
											+ ')"><i class="fas fa-exchange-alt mr-2"></i><span> Revire </span></a>';
								}
								if ((registro.estado == "COTIZADO" || registro.estado == "EN CAPTURA")
										&& registro.estado == "WEB") {
									if (registro.idProducto == 209) {
										textoBoton += '<a class="dropdown-item" href="/group/portal-agentes/empresarial?folioEmpresarial='
												+ registro.folio
												+ '&cotizacionEmpresarial='
												+ registro.cotizacion
												+ '&versionEmpresarial='
												+ registro.version
												+ '&modoEmpresarial=1"><i class="far fa-edit mr-2"></i><span>Editar cotización</span></a>';
									} else if (registro.idProducto == 210) {
										textoBoton += '<a class="dropdown-item" href="/group/portal-agentes/paquete-empresarial-maquetado?folioEmpresarial='
												+ registro.folio
												+ '&cotizacionEmpresarial='
												+ registro.cotizacion
												+ '&versionEmpresarial='
												+ registro.version
												+ '&modoEmpresarial=3"><i class="fas fa-print mr-2"></i><span>  Editar cotización  </span></a>';
									}	else {
										textoBoton += '<a class="dropdown-item" href="/group/portal-agentes/casa-habitacion?folioFamiliar='
												+ registro.folio
												+ '&cotizacionFamiliar='
												+ registro.cotizacion
												+ '&versionFamiliar='
												+ registro.version
												+ '}&modoFamiliar=1"><i class="far fa-edit mr-2"></i><span>Editar cotización</span></a>';
									}

								}
								if ((registro.estado == "COTIZADO" || registro.estado == "EN CAPTURA" || registro.estado == "NO ACEPTADO")
										&& registro.modo == "WEB") {
									if (registro.idProducto == 209) {
										textoBoton += '<a class="dropdown-item" href="/group/portal-agentes/empresarial?folioEmpresarial='
												+ registro.folio
												+ '&cotizacionEmpresarial='
												+ registro.cotizacion
												+ '&versionEmpresarial='
												+ registro.version
												+ '&modoEmpresarial=2"><i class="far fa-clone mr-2"></i><span>Copiar cotización</span></a>';
									} else if (registro.idProducto == 210) {
										textoBoton += '<a class="dropdown-item" href="/group/portal-agentes/paquete-empresarial-maquetado?folioEmpresarial='
												+ registro.folio
												+ '&cotizacionEmpresarial='
												+ registro.cotizacion
												+ '&versionEmpresarial='
												+ registro.version
												+ '&modoEmpresarial=3"><i class="fas fa-print mr-2"></i><span>  Solicitar emisión  </span></a>';
									}	else {
										textoBoton += '<a class="dropdown-item" href="/group/portal-agentes/casa-habitacion?folioFamiliar='
												+ registro.folio
												+ '&cotizacionFamiliar'
												+ registro.cotizacion
												+ '&versionFamiliar'
												+ registro.version
												+ '&modoFamiliar=2"><i class="far fa-clone mr-2"></i><span>Copiar cotización</span></a>';
									}
								}

								if (registro.estado == "COTIZADO") {
									textoBoton += '<a class="dropdown-item" data-toggle="modal" href="#modal-rechazo" onclick="rechazoModal(\''
											+ $( "#rechazoCotizacionURL" ).val()
											+ '\',\''
											+ registro.folio
											+ '\',\''
											+ registro.cotizacion
											+ ' \',\''
											+ registro.version
											+ '\')" ><i class="far fa-trash-alt mr-2"></i><span>  Rechazar propuesta de negocio </span></a>';
								}
								textoBoton += "<a class=\"dropdown-item\" data-toggle=\"modal\" href=\"#modal-messages\" onclick=\"verMensajes ('"
										+ $( "#datosMensajesURL" ).val()
										+ "','"
										+ $( "#saveComentarioURL" ).val()
										+ "','"
										+ registro.folio
										+ "','"
										+ registro.poliza
										+ "','"
										+ registro.cotizacion
										+ "','"
										+ registro.endoso
										+ "','"
										+ registro.version
										+ "' )\"> <i class=\"far fa-comment mr-2\"></i> <span>  Ver mensajes </span></a>"
										+ "<a class=\"dropdown-item\" data-toggle=\"modal\" href=\"#modal-archives\" onclick=\"verArchivos('"
										+ $( "#datosArchivosURL" ).val()
										+ "','"
										+ registro.idCarpeta
										+ "', '"
										+ registro.cotizacion
										+ "', '"
										+ registro.estado
										+ "' )\"> <i class=\"far fa-file-alt mr-2\"></i> <span> Ver archivos </span></a>"
										+ "<a class=\"dropdown-item\" data-toggle=\"modal\" href=\"#modal-help\"><i class=\"fas fa-question mr-2\"></i><span> Ayuda </span></a>"
										+ "</div>" + "</div>	";

								fila += '<td>' + textoBoton + '</td>';
							}
							fila += "</tr>";
							$( selectorTabla ).append( fila );
						} );
						$( selectorTabla ).DataTable( copiaTabla.init() );
						$( selectorTabla ).dataTable().api().page( paginaSeleccionada ).draw( false );
					} else {
						showMessageSuccess( '.navbar', "Fin de registros", 0 );
					}
				} else {
					showMessageError( '.navbar', data.msj, 0 );
				}
			}, "Json" ).always( function() {
				hideLoader();
			} );

} else {
	hideLoader();
	}

}

/**
 * @param {json}
 *            objetoJson - tipos: 0 = cadena, 1 = fecha, 2 = moneda sin
 *            decimales, 3 = moneda con decimales, 4 = numerico, 5 = numerico
 *            con decimales, 6 = porcentaje con punto decimal
 */
function TipoValor(tipo, valor) {
	switch (tipo) {
		case 0: /* Cadena */
			return valor;
		case 1:/* Fecha */
			return stringToDate( valor );
		case 2:/* moneda sin decimales */
			return generaFormatoNumerico( valor, false, true, false );
		case 3:/* moneda con decimales */
			return generaFormatoNumerico( valor, true, true, false );
		case 4:/* Numerico sin decimales */
			return generaFormatoNumerico( valor, false, false, false );
		case 5:/* Numerico con decimales */
			return generaFormatoNumerico( valor, true, false, false );
		case 6:/* Porcentaje */
			return generaFormatoNumerico( valor, true, false, true );
	}
	/* generaFormatoNumerico(num, conDecimales, esMoneda, esPorcentaje) */
}

/**
 * Convertir string to date
 * 
 * @param {string}
 *            cadena - String en formato /Date(1534395600000)/
 * @returns una fecha en formato dd/MM/yyyy
 */
function StringToDate(cadena) {
	if (!valIsNullOrEmpty( cadena )) {
		var resultado = '';
		var str = cadena, character;
		for (var i = 0; i < str.length; i++) {
			character = str.charAt( i );
			if (isCharDigit( character )) {
				resultado += character;
			}
		}

		/*
		 * for( character of str ){ if(isCharDigit(character)){ resultado +=
		 * character; } }
		 */
		var fechaFin = new Date( parseInt( resultado, 10 ) );
		var day = ("0" + (fechaFin.getDate())).slice( -2 );
		var month = ("0" + (fechaFin.getMonth() + 1)).slice( -2 );
		return day + '/' + month + '/' + fechaFin.getFullYear();
	}
	return "";

}

/**
 * @param {string}
 *            value - cadena a evaluar
 * @returns
 */
function ValIsNullOrEmpty(value) {
	if (value === undefined) {
		return true;
	}
	return (value == null || value == "null" || value === "");
}

function IsCharDigit(n) {
	return !!n.trim() && !isNaN( +n );
}

/**
 * @param {decimal ||
 *            string} num - Valor a a evaluar -> numerico
 * @param {bool}
 *            conDecimales - El formato final lo queiren con decimales (true ||
 *            false)
 * @param {bool}
 *            esMoneda - El formato final lo queiren con simbolo de moneda (true ||
 *            false)
 * @param {bool}
 *            esPorcentaje - El formato final lo queiren con simbolo de
 *            porcentaje (true || false)
 */
function GeneraFormatoNumerico(num, conDecimales, esMoneda, esPorcentaje) {
	if (isNaN( num )) {
		console.log( "no es un numero" + num );
		return num;
	}

	num = "" + num;
	var isNegative = "";

	if (num == "") {
		return num;
	}

	if (num.indexOf( '-' ) != -1) {
		isNegative = '-';
		num = num.replace( '-', '' );
	}

	var resultado = "";
	arraySplit = num.split( "." );
	izq = arraySplit[0];
	der = "00";
	if (num.includes( "." )) {
		der = arraySplit[1];
	}
	izq = izq.replace( / /g, "" );
	izq = izq.replace( /\$/g, "" );
	izq = izq.replace( /,/g, "" );

	var izqAux = "";
	var j = 0;
	for (i = izq.length - 1; i >= 0; i--) {
		if (j != 0 && j % 3 == 0) {
			izqAux += ",";
		}
		j++;
		izqAux += izq[i];
	}
	izq = "";
	for (i = izqAux.length - 1; i >= 0; i--) {
		izq += izqAux[i];
	}
	der = der.substring( 0, 2 );
	if (der.length < 2) {
		der += "0";
	}
	resultado = izq;

	if (conDecimales) {
		resultado += "." + der;
	}

	if (esMoneda) {
		resultado = "$" + resultado;
	}

	if (esPorcentaje) {
		resultado = resultado + "%";
	}

	return isNegative + resultado;
}


