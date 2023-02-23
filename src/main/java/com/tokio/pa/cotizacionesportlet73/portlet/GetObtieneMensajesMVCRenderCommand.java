package com.tokio.pa.cotizacionesportlet73.portlet;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.google.gson.Gson;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.cotizador.CotizadorService;
import com.tokio.cotizador.Bean.ComentarioResponse;
import com.tokio.pa.cotizacionesportlet73.constants.CotizacionesPortlet73PortletKeys;

@Component(
		immediate = true, 
		property = { "javax.portlet.name=" + CotizacionesPortlet73PortletKeys.PORTLET_NAME,
					 "mvc.command.name=/cotizacion/obtieneMensajes" },
		service = MVCResourceCommand.class
)
public class GetObtieneMensajesMVCRenderCommand extends BaseMVCResourceCommand{

	
	@Reference
	CotizadorService cotizadorService;

	@Override
	protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws Exception {
		
		try{
			String folio = ParamUtil.getString(resourceRequest, "folio");
			String cotizacion = ParamUtil.getString(resourceRequest, "cotizacion");
			String poliza = ParamUtil.getString(resourceRequest, "poliza");
			String endoso = ParamUtil.getString(resourceRequest, "endoso");
			int version = 1;
			
			
			int tipo = 1;
			ThemeDisplay themeDisplay = (ThemeDisplay)resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
			String usuario = themeDisplay.getUser().getScreenName();
			String pantalla = "Cotizaciones";
			 
			ComentarioResponse comResp = null;
			comResp = cotizadorService.getComentario(folio, cotizacion, version, poliza, endoso, tipo, usuario, pantalla);
			
			Gson gson = new Gson();
			String stringJsonComen = gson.toJson(comResp);
			resourceResponse.getWriter().write(stringJsonComen);
			
		}catch(Exception e){
			String stringJsonComen = "{code:2, msg:\" Error al consultar informacion\"}";
			resourceResponse.getWriter().write(stringJsonComen);
			
		}
		
		
	}
}
