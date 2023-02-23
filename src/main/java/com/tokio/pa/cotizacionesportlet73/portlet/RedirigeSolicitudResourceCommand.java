package com.tokio.pa.cotizacionesportlet73.portlet;

import com.google.gson.JsonObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
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
		property = { "javax.portlet.name=" + CotizacionesPortlet73PortletKeys.PORTLET_NAME,
					 "mvc.command.name=/listCotizaciones/redirigeSolicitud" },
		service = MVCResourceCommand.class
)

public class RedirigeSolicitudResourceCommand extends BaseMVCResourceCommand {
	
	private static final Log _log = LogFactoryUtil.getLog(RedirigeSolicitudResourceCommand.class);

	
	/* (non-Javadoc)
	 * @see com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand#doServeResource(javax.portlet.ResourceRequest, javax.portlet.ResourceResponse)
	 */
	
	@Override
	protected void doServeResource(ResourceRequest resourceRequest,
			ResourceResponse resourceResponse) throws Exception {
		// TODO Auto-generated method stub
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
		
		try {
			
			HttpServletRequest originalRequest = PortalUtil
					.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
			ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
			 
			int folio = ParamUtil.getInteger(resourceRequest, "folio");
			int version = ParamUtil.getInteger(resourceRequest,"version");
			int idCarpeta = ParamUtil.getInteger(resourceRequest,"idCarpeta");
			long cotizacion = ParamUtil.getLong(resourceRequest,"cotizacion");
			String rfc = ParamUtil.getString(resourceRequest, "rfc");
			String endoso = ParamUtil.getString(resourceRequest,"endoso");
			String estado = ParamUtil.getString(resourceRequest,"estado");
			String solicitud = ParamUtil.getString(resourceRequest,"solicitud");
			String descProd = ParamUtil.getString(resourceRequest, "descProducto");
			
			InfoCotizacion inf = new InfoCotizacion();
			
			_log.info("folio : " + folio);
			_log.info("rfc : " + rfc);
			_log.info("version : " + version);
			_log.info("idCarpeta : " + idCarpeta);
			_log.info("cotizacion : " + cotizacion);
			_log.info("endoso : " + endoso);
			_log.info("estado : " + estado);
			_log.info("solicitud: " + solicitud);
			_log.info("descProd: " + descProd);
			
			inf.setFolio(folio);
			inf.setRfc(rfc);
			inf.setVersion(version);
			inf.setIdCarpeta(idCarpeta);
			inf.setCotizacion(cotizacion);
			inf.setEndoso(endoso);
			inf.setEstado(estado);
			inf.setSolicitud(solicitud);
			_log.info(inf);
			
			String parametro = "?infoCotizacion=" + CotizadorModularUtil.encodeURL(inf) 
				+ "&descProducto=" + descProd;
			String tipo = "/consulta-solicitudes";
			
			final long GROUP_ID = themeDisplay.getLayout().getGroupId();
			Layout layout = LayoutLocalServiceUtil.getFriendlyURLLayout(GROUP_ID, true, tipo);
			String urlCotizador = layout.getRegularURL(originalRequest);
			
			_log.info("parametro : " + parametro);
			_log.info("tipo : " + tipo);
			_log.info("urlCotizador : " + urlCotizador);
			
			String jsonString = "{ \"code\" : 0, \"url\" : \"" + urlCotizador + parametro + "\"}"; 
			PrintWriter writer = resourceResponse.getWriter();
			writer.write(jsonString);
			
		} catch (Exception e) {
			// TODO: handle exception
			String jsonString = "{ \"code\" : 1, \"msj\" : \"Error en el proceso\"}"; 
			PrintWriter writer = resourceResponse.getWriter();
			writer.write(jsonString);
			_log.error(e.getMessage(), e);
		}

	}

}
