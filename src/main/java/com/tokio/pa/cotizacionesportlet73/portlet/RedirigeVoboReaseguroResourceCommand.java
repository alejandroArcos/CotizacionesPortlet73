package com.tokio.pa.cotizacionesportlet73.portlet;

import com.google.gson.JsonObject;
import com.liferay.portal.kernel.model.Layout;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.service.LayoutLocalServiceUtil;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.pa.cotizacionesportlet73.constants.CotizacionesPortlet73PortletKeys;
import com.tokio.pa.cotizadorModularServices.Bean.InfoCotizacion;
import com.tokio.pa.cotizadorModularServices.Enum.ModoCotizacion;
import com.tokio.pa.cotizadorModularServices.Enum.TipoCotizacion;
import com.tokio.pa.cotizadorModularServices.Util.CotizadorModularUtil;

import java.io.PrintWriter;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;

import org.osgi.service.component.annotations.Component;

@Component(
		immediate = true,
		property = {
				"javax.portlet.name=" + CotizacionesPortlet73PortletKeys.PORTLET_NAME,
					"mvc.command.name=/list/cotizacion/redirigeVoboReaseguro" 
				},
		service = MVCResourceCommand.class
)

public class RedirigeVoboReaseguroResourceCommand extends BaseMVCResourceCommand {
	
	@Override
	protected void doServeResource(ResourceRequest resourceRequest,
			ResourceResponse resourceResponse) throws Exception {
		// TODO Auto-generated method stub
		JsonObject obj = new JsonObject();
		
		try {
			HttpServletRequest originalRequest = PortalUtil
					.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
			ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest
					.getAttribute(WebKeys.THEME_DISPLAY);
			
			final long GROUP_ID = themeDisplay.getLayout().getGroupId();
			Layout layout = LayoutLocalServiceUtil.getFriendlyURLLayout(GROUP_ID, true, "/rea-coa");
			String urlCotizador = layout.getRegularURL(originalRequest);
			
			int folio = ParamUtil.getInteger(resourceRequest, "folio");
			int cotizacion = ParamUtil.getInteger(resourceRequest, "cotizacion");
			int version = ParamUtil.getInteger(resourceRequest, "version");
			int idProducto = ParamUtil.getInteger(resourceRequest, "idProducto");
			
			InfoCotizacion infCotizacion = new InfoCotizacion();
			
			infCotizacion.setFolio(folio);
			infCotizacion.setVersion(version);
			infCotizacion.setCotizacion(cotizacion);
			infCotizacion.setModo(ModoCotizacion.VOBO_REASEGURO);
			infCotizacion.setRc(2);
			
			switch(idProducto) {
				case 3149:
					infCotizacion.setTipoCotizacion(TipoCotizacion.RC);
					break;
				case 211:
					infCotizacion.setTipoCotizacion(TipoCotizacion.TRANSPORTES);
					break;
				case 210:
					infCotizacion.setTipoCotizacion(TipoCotizacion.EMPRESARIAL);
					break;
				default:
					break;
			}
			
			
			String parametro = "?infoCotizacion=" + CotizadorModularUtil.encodeURL(infCotizacion);
			
			obj.addProperty("code", 0);
			obj.addProperty("msg", "ok");
			obj.addProperty("url", urlCotizador + parametro);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			obj.addProperty("code", 2);
			obj.addProperty("msg", "Error al redireccionar, informacion incompleta");
		}
		
	
		
		PrintWriter writer = resourceResponse.getWriter();
		writer.write(obj.toString());
	}

}
