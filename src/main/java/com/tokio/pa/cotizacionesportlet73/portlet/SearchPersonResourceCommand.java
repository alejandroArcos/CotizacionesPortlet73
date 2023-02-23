package com.tokio.pa.cotizacionesportlet73.portlet;

import java.io.PrintWriter;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.cotizador.CotizadorService;
import com.tokio.cotizador.Bean.PersonaResponse;
import com.tokio.pa.cotizacionesportlet73.constants.CotizacionesPortlet73PortletKeys;


@Component(
	    immediate = true,
	    property = {
		        "javax.portlet.name="+ CotizacionesPortlet73PortletKeys.PORTLET_NAME,
		        "mvc.command.name=/cotizacion/searchPerson"
	    },
	    service = MVCResourceCommand.class
	)

public class SearchPersonResourceCommand extends BaseMVCResourceCommand{
	@Reference
	CotizadorService cotizadorService; 
	
	@Override
	protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws Exception {
		/************************** Validación metodo post **************************/
		if ( !resourceRequest.getMethod().equals("POST")  ){
			JsonObject requestError = new JsonObject();
			requestError.addProperty("code", 500);
			requestError.addProperty("msg", "Error en tipo de consulta");
			PrintWriter writer = resourceResponse.getWriter();
			writer.write(requestError.toString());
			return;
		}
		/************************** Validación metodo post **************************/
		
		User user = (User) resourceRequest.getAttribute(WebKeys.USER);
		String usuario = user.getScreenName();
		String pantalla = "Cotizaciones";
		String nombrecliente = ParamUtil.getString(resourceRequest, "term");
		int tipo =1;//1 para cliente
		
		PersonaResponse respuesta = cotizadorService.getListaPersonas(nombrecliente, tipo, usuario, pantalla);
		
		if(respuesta.getCode() ==0 ){
			Gson gson = new Gson();
			String jsonString = gson.toJson(respuesta.getListaPersona());
			PrintWriter writer = resourceResponse.getWriter();
			writer.write(jsonString);
			
		}
		
	}
	 	
	

}
