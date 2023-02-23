$( document ).ready(function() {
    console.log( "ready!" );
   
    var myDate = new Date();
    /*
    finInputA = $('#fechaFAgente').pickadate({ 
	    format : 'dd/mm/yyyy',
		formatSubmit : 'dd/mm/yyyy'
	});
   
   finPickerA=finInputA.pickadate('picker');
   
   finInputT = $('#fechaFTokio').pickadate({ 
	    format : 'dd/mm/yyyy',
		formatSubmit : 'dd/mm/yyyy'
	});
  
  finPickerT=finInputT.pickadate('picker');
  
  inicioInputA = $('#fechaIAgente').pickadate({ 
	    format : 'dd/mm/yyyy',
		formatSubmit : 'dd/mm/yyyy'
	});
 
 inicioPickerA=inicioInputA.pickadate('picker');

 inicioInputT = $('#fechaITokio').pickadate({ 
	    format : 'dd/mm/yyyy',
		formatSubmit : 'dd/mm/yyyy'
	});
 */
 	
 	
 	var finInputA = $('#fechaFAgente').datepicker({ 
	    format : 'dd/mm/yyyy',
		formatSubmit : 'dd/mm/yyyy'
	});
   
   finPickerA=finInputA.datepicker('picker');
   
   finInputT = $('#fechaFTokio').datepicker({ 
	    format : 'dd/mm/yyyy',
		formatSubmit : 'dd/mm/yyyy'
	});
  
  finPickerT=finInputT.datepicker('picker');
  
  inicioInputA = $('#fechaIAgente').datepicker({ 
	    format : 'dd/mm/yyyy',
		formatSubmit : 'dd/mm/yyyy'
	});
 
 inicioPickerA=inicioInputA.datepicker('picker');

 inicioInputT = $('#fechaITokio').datepicker({ 
	    format : 'dd/mm/yyyy',
		formatSubmit : 'dd/mm/yyyy'
	});
 

  inicioPickerT=inicioInputT.pickadate('picker');

  $(".fecha").each(function() {
		value = $(this).text();
		value = new Date(parseInt(value.replace("/Date(", "").replace(")/",""), 10));
		month = value.getMonth() + 1;
		console.log(month);
		if( month <=9){
			month = "0" + month;
		}
		$(this).text( value.getDate() +"/"+ month +"/"+value.getFullYear() )
	});
  
  
	
	$( "#AseguradoAgente" ).autocomplete({
	      minLength: 3,
	      source: "<%=searchPersonURL%>",
	      focus: function( event, ui ) {
	        $( "#AseguradoAgente" ).val( ui.item.nombrepersona );
	        return false;
	      },
	      select: function( event, ui ) {
	        $( "#AseguradoAgente" ).val( ui.item.nombre + " "+ ui.item.appMaterno+" " + ui.item.appPaterno );
	        $("#aAseguradoId").val( ui.item.idPersona );
	        return false;
	      }
	    }).autocomplete( "instance" )._renderItem = function( ul, item ) {
			console.log( item );
			if( item.idDenominacion == 0 ){
			      return $( "<li>" )
			        .append( "<div>" + item.nombre + " "+ item.appPaterno +" " + item.appMaterno + "</div>" )
			        .appendTo( ul );
			}else{
			      return $( "<li>" )
			        .append( "<div>" + item.nombre + "</div>" )
			        .appendTo( ul );
				
			}

	    };	  

		
		$( "#tAsegurado" ).autocomplete({
		      minLength: 3,
		      source: "<%=searchPersonURL%>",
		      focus: function( event, ui ) {
		        $( "#tAsegurado" ).val( ui.item.nombrepersona );
		        return false;
		      },
		      select: function( event, ui ) {
		        $( "#tAsegurado" ).val( ui.item.nombre + " "+ ui.item.appMaterno+" " + ui.item.appPaterno );
		        $("#tAseguradoId").val( ui.item.idPersona );
		        return false;
		      }
		    }).autocomplete( "instance" )._renderItem = function( ul, item ) {
				console.log( item );
				if( item.idDenominacion == 0 ){
				      return $( "<li>" )
				        .append( "<div>" + item.nombre + " "+ item.appPaterno +" " + item.appMaterno + "</div>" )
				        .appendTo( ul );
				}else{
				      return $( "<li>" )
				        .append( "<div>" + item.nombre + "</div>" )
				        .appendTo( ul );
					
				}

		    };	  
		    

});

/*
$('.data-table').on('draw.dt', function(e) {
	console.log(e);
	e.preventDefault();
	console.log('entre');
});
*/



$( "#fechaIAgente" ).change(function() {
	
	console.log("------------------------------------------");
	console.log("entro a cambiar fecha");
	var fechaIn = $( "#fechaIAgente" ).val();
	console.log( fechaIn );
	if( fechaIn == "" ){
		return;
	}
	console.log( "paso" );
	finPickerA.set('min', inicioPickerA.get('select'));
	var nf = fechaIn.split("/");
	var otra = new Date(nf[1]+"/"+nf[0]+"/"+nf[2]);
	otra.setDate( otra.getDate() + 90 );
	finPickerA.set('max', otra);

});


$( "#fechaITokio" ).change(function() {
	console.log("------------------------------------------");
	console.log("entro a cambiar fecha");
	var fechaIn = $( "#fechaITokio" ).val();
	console.log( fechaIn );
	if( fechaIn == "" ){
		return;
	}
	console.log( "paso" );
	finPickerT.set('min', inicioPickerT.get('select'));
	var nf = fechaIn.split("/");
	var otra = new Date(nf[1]+"/"+nf[0]+"/"+nf[2]);
	otra.setDate( otra.getDate() + 90 );
	finPickerT.set('max', otra);

	
});


function verArchivos( url, idCarpeta, cotizacion, estado ){
	console.log("obtiene docs");
	$("#subirArchivoForm").hide();
	$("#subirArchivoModal").hide();
	$("#tableArchivos tbody").html("");
	$("#idCarpetaArchivo").val(idCarpeta);
	$("#idCotizacionArchivo").val(cotizacion);
	console.log(estado);
	if( estado == "SE NECESITAN MÃS DATOS" || estado == "EN CAPTURA"  ){
		console.log("muestra");
		$("#subirArchivoForm").show();
		$("#subirArchivoModal").show();
	}else{
		console.log("oculta");
		$("#subirArchivoForm").hide();
		$("#subirArchivoModal").hide();
	}
	
	console.log("----");
	console.log("idCarpeta" + idCarpeta);
	console.log("----");

	showLoader();
	$.ajax({
        url: url,
        type: 'POST',
        data: {cotizacion: idCarpeta},
       	success: function(data){
       		var archivo = JSON.parse(data);
       		console.log("respuesta archivo:"+ data);
			var htmlTabla;
       		$.each(archivo.listaDocumento, function(i, stringJson) { 
       			
                htmlTabla = "<tr>"
            	  
				+"<td>"+stringJson.nombre+ stringJson.extension +"</td>"
				+"<td>"+stringJson.tipo+"</td>"
				+"<td <button class=\"btn btn-primary \" onclick=\" descargarDocumento( "+stringJson.idCarpeta+ ","+stringJson.idDocumento
				+","+stringJson.idCatalogoDetalle +") \"> Descargar </button> </td>"
				+"</tr>";

				$('#tableArchivos tbody').append(htmlTabla);
            	      	 
		  	});
				$("#modal-archives").modal("show");
       		
		}
    }).always( function() {
        hideLoader();
    } );
}


function  descargarDocumento( idCarpeta,idDocumento,idCatalogoDetalle) {
	/* llamar a descargar documento */
	
	console.log("obtiene docs");
	showLoader();
	$.ajax({
        url: '<%=descargarDocumento%>',
        type: 'POST',
        data: {idCarpeta: idCarpeta,idDocumento:idDocumento,idCatalogoDetalle:idCatalogoDetalle},
       	success: function(data){

       		var archivo = JSON.parse(data);
       		
       		if( archivo.code ==0 ){
				
				/*
       			fileAux = 'data:application/octet-stream;base64,'+archivo.documento
				var dlnk = document.getElementById('dwnldLnk');
				dlnk.href = fileAux;
				dlnk.download = archivo.nombre+'.'+archivo.extension;
				dlnk.click();
				
				*/
				
				if(detectIEEdge()){
					fileAux = 'data:application/octet-stream;base64,'+archivo.documento
					var dlnk = document.getElementById('dwnldLnk');
					dlnk.href = fileAux;
					dlnk.download = archivo.nombre+'.'+archivo.extension;
					location.href=document.getElementById("dwnldLnk").href;
					/*dlnk.click();*/
				}else{
					/*
					 * downloadDocument('archivo base 64' , 'nombre.extension' );
					 */
					downloadDocument(archivo.documento, archivo.nombre+'.'+archivo.extension);
				}
       			
				hideLoader();
       		}else{
				showMessageError(".navbar",archivo.msg, 0);
       		}
       		
       	}	            
    }).always( function() {
        hideLoader();
    } );
	
	
}

function urltoFile(url, filename, mimeType){
    return (fetch(url)
        .then(function(res){return res.arrayBuffer();})
        .then(function(buf){return new File([buf], filename, {type:mimeType});})
    );
}

function verMensajes(url,url2, folio ,poliza,cotizacion,endoso,version, tipo){
	console.log("obtiene mensajes");
	$("#listaComentarios").html("");
	$("#textoAgregarComentario").val("");
	
	showLoader();
	agregarComentarioModal(url2,cotizacion,version, tipo);
	$.ajax({
        url: url,
        type: 'POST',
        data: {folio: folio,poliza:poliza,cotizacion:cotizacion,endoso:endoso,version:version},
       	success: function(data){
       		var comentario = JSON.parse(data);
       		
			$.each(comentario.listaComentario, function(i, stringJson) { 
       			
                var lista;
                var nom = stringJson.usuario;
                var iniciales = nom.substring(0, 1);
                lista = "<li class='justify-content-between mb-3'>"
            	  
                  +"<div class='comment-body white p-3 z-depth-1'>"
                  +"<div class='header'>"
                  +"<div class='user-acronym btn-floating btn-sm light-blue darken-4 waves-effect waves-light'>"
                  +"<span>"+iniciales.toUpperCase()+"</span>"
                  +"</div>"
                  +"<strong class='primary-font'>"+ stringJson.usuario +"</strong>"
            	  +"<small class='pull-right text-muted'><i class='fa fa-clock-o'></i>"+ stringJson.fecha +"</small>"
            	  +"</div>"
				  +"<hr class='w-100'>"
                  +"<h6 class='font-weight-bold mb-2'><strong>" /*+stringJson.idcomentario*/+"</strong></h6>"
                  +"<p class='mb-0'>" +stringJson.comentario  + "</p>"
				  +"</div>"
 
            	  +"</li>";
				
            	  $("#listaComentarios").append(lista);
            	      	 
              });
			$("#modal-messages").modal('show');
       		
       	}	        
    }).always( function() {
        hideLoader();
    } );
}

function revireModal(url, cotizacion,version){
	$("#urlRevire").val(url);
	$("#urlRevireCotizacion").val(cotizacion);
	$("#urlRevireVersion").val(version);

	$("#comentarioRevireId").val("");
	$("#modal-revire").modal("show");
}

function rechazoModal(url,folio ,cotizacion,version){
	$("#urlRechazo").val(url);
	$("#urlRechazoCotizacion").val(cotizacion);
	$("#urlRechazoVersion").val(version);

	$("#comentarioRechazoId").val("");
	$("#rechazoLabel").text("Rechazar propuesta de negocio con folio " + folio);
	
}

function agregarComentarioModal(url,cotizacion,version, tipo){
	$("#urlAgregarComentario").val(url);
	$("#cotizacionComentario").val(cotizacion);
	$("#versionComentario").val(version);
	$("#tipo").val(tipo);
}

function revireSubmit(  ){
	url = $("#urlRevire").val();
	cotizacion = $("#urlRevireCotizacion").val();
	version = $("#urlRevireVersion").val();

	showLoader();
	$.ajax({
        url: url,
        type: 'POST',
        data: {comentario: $("#comentarioRevireId").val(),cotizacion: $("#urlRevireCotizacion").val(),version: $("#urlRevireVersion").val() },
       	success: function(data){
       		console.log(data)
       		var respuesta = JSON.parse(data);
       		console.log(respuesta);
       		console.log(respuesta);
			if( respuesta.code == 0 ){
				showMessageSuccess(".navbar",respuesta.msg, 0);
			}else{
				showMessageError(".navbar",respuesta.msg, 0);
			}
			$("#modal-revire").modal("hide");
			setTimeout(recargaPagina, 5000);
       		
       	}	        
    }).always( function() {
        hideLoader();
    } );
	
}

function agregarComentarioSubmit(  ){
	url = $("#urlAgregarComentario").val();

	showLoader();
	$.ajax({
        url: url,
        type: 'POST',
        data: {comentario: $("#textoAgregarComentario").val(),cotizacion: $("#cotizacionComentario").val(), version: $("#versionComentario").val(),tipo:$("#tipo").val() },
       	success: function(data){
       		console.log(data)
       		var respuesta = JSON.parse(data);
       		console.log(respuesta);
			if( respuesta.code == 0 ){
				showMessageSuccess(".navbar",respuesta.msg, 0);
			}else{
				showMessageError(".navbar",respuesta.msg, 0);
			}
       		
       	}	        
    }).always( function() {
    	$("#textoAgregarComentario").val("");
        hideLoader();
        $("#modal-messages").modal('toggle');
    } );
	
}

function rechazoSubmit(  ){
	url = $("#urlRechazo").val();
	showLoader();
	$.ajax({
        url: url,
        type: 'POST',
        data: {motivoRechazo: $("#motivoSelect").val(), motivo : $("#comentarioRechazoId").val(),cotizacion: $("#urlRechazoCotizacion").val(),version:$("#urlRechazoVersion").val() },
       	success: function(data){
       		var respuesta = JSON.parse(data);
       		console.log(respuesta);
			if( respuesta.code ==0 ){
				
				showMessageSuccess(".navbar",respuesta.msg, 0);
			}else{
				showMessageError(".navbar",respuesta.msg, 0);
			}
			setTimeout(recargaPagina, 5000);
       	}	        
    }).always( function() {
        $("#modal-rechazo").modal('toggle');
        hideLoader();
    } );
}

function submitTmx(url,cotizacion,version){

	showLoader();
	$.ajax({
        url: url,
        type: 'POST',
        data: {tmx: 1,cotizacion: cotizacion,version: version },
       	success: function(data){
       		var respuesta = JSON.parse(data);
       		console.log(respuesta);
			if( respuesta.code ==0 ){
				showMessageSuccess(".navbar",respuesta.msg, 0);
		        hideLoader();
				setTimeout(recargaPagina, 5000);
			}else{
				showMessageError(".navbar",respuesta.msg, 0);
			}

       		
       	}	        
    }).always( function() {
        hideLoader();
    } );
}

function recargaPagina(){
	 window.location.reload();
}

/*
$(".tablaTokio").on("draw.dt", function (e){
	var ultimoT = $(this).siblings().find("li").last().prev();
	if( ultimoT.hasClass("active") ){
		generaTablas( 
				"#pendientes-tokio #search-form",
				"${tokioAjax}",
				".tablaTokio",
				jsonCampoTokio,
				"listaCotizacion",
				btnTokio
		)
	}
});

$(".tablaAgente").on("draw.dt", function (e){
	var ultimoT = $(this).siblings().find("li").last().prev();
	if( ultimoT.hasClass("active") ){
		customGeneraTablas( 
				"#pendientes-agente #search-form",
				"${agentesAjax}",
				".tablaAgente",
				
				jsonCampoAgente,
				"listaCotizacion",
				btnAgente
		);.promise().done(function(){
			console.log("termina ahora");
		});
	}
});
*/

var btnAgente = {
		"requerido" : true,
		"html": "     <div class=\"actions-container dropleft\">"+
        "<button type=\"button\" class=\"btn btn-outline-pink dropdown-menu-right px-3 py-2 waves-effect waves-light\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">"+
            "<i class=\"fa fa-ellipsis-v\" aria-hidden=\"true\"></i>"+
        "</button>"+
		"<div class=\"dropdown-menu animated fadeIn\" >"+
		"&#191;?"+
		"<a class=\"dropdown-item\" data-toggle=\"modal\" href=\"#modal-messages\" onclick=\"verMensajes (${datosMensajes}, ${saveComentarioURL},'&#191;?','&#191;?','&#191;?','&#191;?','&#191;?' )\"> <i class=\"far fa-comment mr-2\"></i> <span>  Ver mensajes </span></a>"+
		"<a class=\"dropdown-item\" data-toggle=\"modal\" href=\"#modal-archives\" onclick=\"verArchivos(${datosArchivos},'&#191;?','&#191;?','&#191;?')\"> <i class=\"far fa-file-alt mr-2\"></i> <span> Ver archivos </span></a>"+
        "<a class=\"dropdown-item\" data-toggle=\"modal\" href=\"#modal-help\"><i class=\"fas fa-question mr-2\"></i><span> Ayuda </span></a>"+
		 "</div>"+
	"</div>	",
		"listaRemplazo": [ "folio","poliza","cotizacion","endoso","version","idCarpeta","cotizacion" ]
}



var btnTokio = {
		"requerido" : true,
		"html": "     <div class=\"actions-container dropleft\">"+
        "<button type=\"button\" class=\"btn btn-outline-pink dropdown-menu-right px-3 py-2 waves-effect waves-light\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">"+
            "<i class=\"fa fa-ellipsis-v\" aria-hidden=\"true\"></i>"+
        "</button>"+
		"<div class=\"dropdown-menu animated fadeIn\" >"+
		"<a class=\"dropdown-item\" data-toggle=\"modal\" href=\"#modal-messages\" onclick=\"verMensajes (${datosMensajes}, ${saveComentarioURL},'&#191;?','&#191;?','&#191;?','&#191;?','&#191;?' )\"> <i class=\"far fa-comment mr-2\"></i> <span>  Ver mensajes </span></a>"+
		"<a class=\"dropdown-item\" data-toggle=\"modal\" href=\"#modal-archives\" onclick=\"verArchivos(${datosArchivos},'&#191;?','&#191;?','&#191;?')\"> <i class=\"far fa-file-alt mr-2\"></i> <span> Ver archivos </span></a>"+
		  	"<a class=\"dropdown-item\" data-toggle=\"modal\" href=\"#modal-short-help\" onclick=\"\"> <i class=\"fas fa-question mr-2\"></i> <span> ayuda </span></a>"+
		 "</div>"+
	"</div>	",
		"listaRemplazo": [ "folio","poliza","cotizacion","endoso","version","idCarpeta","cotizacion","estado" ]
}

jsonCampoAgente = [
	{
		"nombre": "folio",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "version",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "folio",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "fechaCreacion",
		"tipo": 1 ,
		"attrCelda": "" 
	},
	{
		"nombre": "modo",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "estado",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "producto",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "asegurado",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "agente",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "moneda",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "ramo",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "tipoMovimiento",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "poliza",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "endoso",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "prima",
		"tipo": 5 ,
		"attrCelda": "" 
	}
]




var jsonCampoTokio =  [
	{
		"nombre": "folio",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "fechaCreacion",
		"tipo": 1 ,
		"attrCelda": "" 
	},
	{
		"nombre": "modo",
		"tipo": 0 ,
		"attrCelda": "" 
	},
	{
		"nombre": "estado",
		"tipo": 0 ,
		"attrCelda": ""
	},
	{
		"nombre": "producto",
		"tipo": 0 ,
		"attrCelda": ""
	},
	{
		"nombre": "asegurado",
		"tipo": 0 ,
		"attrCelda": ""
	},
	{
		"nombre": "agente",
		"tipo": 0 ,
		"attrCelda": ""
	},
	{
		"nombre": "moneda",
		"tipo": 0 ,
		"attrCelda": ""
	},
	{
		"nombre": "ramo",
		"tipo": 0 ,
		"attrCelda": ""
	},
	{
		"nombre": "tipoMovimiento",
		"tipo": 0 ,
		"attrCelda": ""
	},
	{
		"nombre": "poliza",
		"tipo": 0 ,
		"attrCelda": ""
	},
	{
		"nombre": "endoso",
		"tipo": 0 ,
		"attrCelda": ""
	},
	{
		"nombre": "prima",
		"tipo": 5,
		"attrCelda": ""
	}
];

/*
var fileinput_options = {
		  showPreview: false,
		  elErrorContainer: '#kartik-file-errors',
		  language: 'es',
		  uploadAsync: false,
	  };
	  


var comisionFile = $("#input-b9").fileinput(
		fileinput_options	
		
).on('filebatchuploadsuccess', function(event, data) {
	  var form = data.form, files = data.files, extra = data.extra,
      response = JSON.parse(data.response), reader = data.reader;
		console.log(response);
		console.log(reader);
	  console.log('File batch upload success');
}).on('filebatchuploaderror', function(event, data, msg) {
  var form = data.form, files = data.files, extra = data.extra,
      response = data.response, reader = data.reader;
  console.log('File batch upload error');
  hideFiles();
  hideLoader();
});
	
*/


function subirArchivoCot(){
	console.log("intento subir archivo");
	var url=$("#subirArchivoForm").attr("action");
	showLoader();

	 var formData = new FormData();
	    formData.append("file", $('#input-b9')[0].files[0]);
	    
	    formData.append("idCotizacion", $("#idCotizacionArchivo").val()  );
	    formData.append("idCarpeta", $("#idCarpetaArchivo").val()  );
	$.ajax({
        url: url,
        type: 'POST',
        data: formData,
        processData: false,  /* tell jQuery not to process the data*/
        contentType: false,  /* tell jQuery not to set contentType*/
       	success: function(data){
			console.log(data);
            var jsonResponse = JSON.parse( data );
            if( jsonResponse.msg == "OK" || jsonResponse.msg == "ok" || jsonResponse.msg == "Ok"  ){
		    	mensaje ="Archivo agregado con &Eacute;xito";
				showMessageSuccess(".navbar",mensaje , 0);
				$("#modal-archives").modal('toggle');
				hideLoader();
            }else{
		    	mensaje ="Error al subir el archivo";
				showMessageError(".navbar",mensaje , 0);
				$("#modal-archives").modal('toggle');
				hideLoader();
            }
			
       	}
    }).always( function() {
        hideLoader();
    } );
	
	
}