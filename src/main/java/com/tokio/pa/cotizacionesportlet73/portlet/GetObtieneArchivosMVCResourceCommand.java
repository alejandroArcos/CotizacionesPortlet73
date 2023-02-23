package com.tokio.pa.cotizacionesportlet73.portlet;

import java.io.PrintWriter;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.cotizador.CotizadorService;
import com.tokio.cotizador.Bean.DocumentoResponse;
import com.tokio.pa.cotizacionesportlet73.constants.CotizacionesPortlet73PortletKeys;

@Component(
		immediate = true, 
		property = { "javax.portlet.name=" + CotizacionesPortlet73PortletKeys.PORTLET_NAME,
					 "mvc.command.name=/cotizacion/obtieneArchivos" },
		service = MVCResourceCommand.class
)

public class GetObtieneArchivosMVCResourceCommand extends BaseMVCResourceCommand{

	
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
		
		
		int idCarpeta = ParamUtil.getInteger(resourceRequest, "cotizacion");
		int rowNum = 0;
		String tipo = "";
		int activo = 1;
		int idDocumento = 0;
		int idCatalogoDetalle = 0;
		String parametros = null;
		ThemeDisplay themeDisplay = (ThemeDisplay)resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		String usuario = themeDisplay.getUser().getScreenName();
		String pantalla = "Cotizaciones";
		System.out.println("idCarpeta " + idCarpeta );
		
		DocumentoResponse docResp = null; 
		docResp = cotizadorService.getListaDocumentos( rowNum, idCarpeta, idDocumento, idCatalogoDetalle, tipo, activo, parametros, usuario, pantalla);
		//pasar a string json  
		Gson gson = new Gson();
		String stringJson = gson.toJson(docResp);
		resourceResponse.getWriter().write(stringJson);

		
		
	}

}
