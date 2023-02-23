
/**
 * 
 * @param tipo --> entero 1--familiar, 2-- empresarial 
 * @param folio
 * @param cotizacion
 * @param version
 * @returns redireccion a cotizacion
 */




function redirigeCotizacion(folio, cotizacion, version, modo, /*poliza, endoso,*/ isEndoso, codEndoso, idProducto){
	
	if(isEndoso){
		switch (codEndoso) {
			case 'AA110':
				/*alta de endoso*/
				modo = 3;
				break;
			case 'DD180':
				/*baja de endoso*/
				modo = 4;
				break;
			default:
				modo = 3;
				break;
		}
	}
	
	$.post( redirigeURL, {
		folio : folio,
		cotizacion : cotizacion,
		version : version,
		modo : modo,
		isEndoso : isEndoso,
		codEndoso : codEndoso,
		idProducto: idProducto
	} ).done(function(data) {
		console.log(data);
		var response = JSON.parse( data );
		
		if(response.code == 0){
			window.location.href = response.url;
		}else{
			
		}
		
	});	
}

function redirigeSolicitud(folio, rfc, cotizacion, endoso, idCarpeta, estado, version, solicitud, descProd) {
	
	$.post( redirigeSolicitudURL, {
		folio: folio,
		rfc: rfc,
		cotizacion:cotizacion,
		endoso: endoso,
		idCarpeta: idCarpeta,
		estado: estado,
		version: version,
		solicitud: solicitud,
		descProducto: descProd
	}).done(function(data) {
		
		var response = JSON.parse( data );
	
		if(response.code == 0) {
			window.location.href = response.url;
		}
		else {
			
		}
	
	});
}


function redirigeCotizacionRenovacion(tipo, folio, cotizacion, version, polAnt, modo, idProducto){
	$.post( redirigeURL, {
		tipo : tipo,
		folio : folio,
		cotizacion : cotizacion,
		version : version,
		modo : modo,
		polAnt : polAnt,
		idProducto: idProducto
	} ).done(function(data) {
		console.log(data);
		var response = JSON.parse( data );
		console.log(response);
		if(response.code == 0){
			window.location.href = response.url;
		}else{
			
		}
		
	});	
}



/*



function redirigeCotizacion(tipo, folio, cotizacion, version, modo, isEndoso, codEndoso){
	if(isEndoso > 0){
		
	}else{		
		var search = "";
		var pathname = "";
		var url = new URL(window.location.href);
		if (url.origin.includes("localhost")){
			if(tipo == 1){
				pathname = "/group/tokio-marine/paquete-familiar";			
			}else{
				pathname = "/group/tokio-marine/paquete-empresarial";						
			}
		}else{
			if(tipo == 1){
				pathname = "/group/portal-agentes/paquete-familiar";
			}else{
				pathname = "/group/portal-agentes/paquete-empresarial";
			}
		}
		if(tipo == 1){
			search ='?folioFamiliar=' + folio +
			'&cotizacionFamiliar=' + cotizacion +
			'&versionFamiliar=' + version +
			'&modoFamiliar=' + modo;
		}else{
			search = '?folioEmpresarial=' + folio +
			'&cotizacionEmpresarial=' + cotizacion +
			'&versionEmpresarial=' + version +
			'&modoEmpresarial='+ modo;
		}
		window.location.href = url.origin + pathname + search;
	}
}

function editaEndoso(tipo, folio, cotizacion, version, modo, isEndoso, codEndoso){
	
}
*/

function validaVigenciaCotizacion(url, folio, cotizacion, version) {
	$.post( $( '#txtRetroactividad' ).val(), {
		cotizacion : cotizacion, version : version
	} ).done(
			function(data) {
				var response = JSON.parse( data )
				if (response.code == 0) {
					
					redirigeCotizacion(url, folio, cotizacion, version, 3);
				
				} else {
					console.log( response.msg );
					$( '#modal-cotExpCot #cotExpCotTxt' ).text( response.msg );
					$( '#modal-cotExpCot' ).modal( 'show' );
				}
			} );
}

function cotizaSuscriptor(tipo,folio, cotizacion, version, idProducto){
	
	switch(idProducto) {
		case 3148:
		case 3149:
		case 211:
		case 210:
		case 836:
		case 7728:
		case 7729:
		case 7730:
			
			$.post( redirigeURL, {
				folio : folio,
				cotizacion : cotizacion,
				version : version,
				modo : 10,
				isEndoso : false,
				codEndoso : '',
				idProducto: idProducto
			} ).done(function(data) {
				console.log(data);
				var response = JSON.parse( data );
				
				if(response.code == 0){
					window.location.href = response.url;
				}else{
					
				}
				
			});
			
			break;
		default:
			var search = "";
			var pathname = "";
			var url = new URL(window.location.href);
			if (url.origin.includes("localhost")){
				if(tipo == 1){
					pathname = "/group/tokio-marine/casa-habitacion";			
				}else{
					pathname = "/group/tokio-marine/empresarial";						
				}
			}else{
				if(tipo == 1){
					pathname = "/group/portal-agentes/paquete-familiar";
				}else{
					pathname = "/group/portal-agentes/paquete-empresarial";
				}
			}
			if(tipo == 1){
				search ='?folioFamiliar=' + folio +
				'&cotizacionFamiliar=' + cotizacion +
				'&versionFamiliar=' + version +
				'&modoFamiliar=1&leg492=factura';
			}else{
				search = '?folioEmpresarial=' + folio +
				'&cotizacionEmpresarial=' + cotizacion +
				'&versionEmpresarial=' + version +
				'&modoEmpresarial=1&leg492=factura';
			}
			window.location.href = url.origin + pathname + search;
			break;
	}
}


function pol360(tipo, poliza, endoso){
	showLoader();
	$.post( redirige360URL, {
		tipo : tipo,
		poliza : poliza,
		endoso : endoso
	} ).done(function(data) {
		var response = JSON.parse( data );
		if(response.code == 0){
			window.location.href = response.url;
		}else{
			hideLoader();
			showMessageError( '.navbar', response.msg, 0 );
		}	
	});
}

function voboReaseguro(folio, cotizacion, version, idProducto) {
	
	$.post(redirigeReaseguroURL, {
		folio: folio,
		cotizacion: cotizacion,
		version: version,
		idProducto: idProducto
	}).done(function(data) {
		var response = JSON.parse( data );
		if(response.code == 0){
			window.location.href = response.url;
		}else{
			hideLoader();
			showMessageError( '.navbar', response.msg, 0 );
		}
	});
}


function downloadBlob(blob, filename){
    if(window.navigator.msSaveOrOpenBlob) {
        window.navigator.msSaveBlob(blob, filename);
    } else {
        var elem = window.document.createElement('a');
        elem.href = window.URL.createObjectURL(blob);
        elem.download = filename;
        document.body.appendChild(elem);
        elem.click();
        document.body.removeChild(elem);
    }
}

function downloadDocument(strBase64, filename) {
    var url = "data:application/octet-stream;base64," + strBase64;  
    var documento = null;
    /*.then(res => res.blob())*/
    fetch(url)
    .then(function(res){return res.blob()})
    .then(function(blob) {
      downloadBlob(blob, filename);
    });
}


function detectIEEdge() {
    var ua = window.navigator.userAgent;

    var msie = ua.indexOf('MSIE ');
    if (msie > 0) {
        /* IE 10 or older => return version number*/
    	console.log(parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10));
        return true;
    }

    var trident = ua.indexOf('Trident/');
    if (trident > 0) {
        /* IE 11 => return version number*/
        var rv = ua.indexOf('rv:');
        console.log(parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10));
        return true;
    }

    var edge = ua.indexOf('Edge/');
    if (edge > 0) {
       /* Edge => return version number*/
    	console.log(parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10));
       return true;
    }

    /* other browser*/
    return false;
}