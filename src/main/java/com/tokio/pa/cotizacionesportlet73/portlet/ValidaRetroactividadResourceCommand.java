package com.tokio.pa.cotizacionesportlet73.portlet;

import com.google.gson.JsonObject;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.cotizador.CotizadorService;
import com.tokio.cotizador.Bean.RetroactividadRequest;
import com.tokio.cotizador.Bean.ValidaResponse;
import com.tokio.pa.cotizacionesportlet73.constants.CotizacionesPortlet73PortletKeys;

import java.io.PrintWriter;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;


@Component(
		immediate = true,
		 property = {
				 "javax.portlet.name="+ CotizacionesPortlet73PortletKeys.PORTLET_NAME,
				 "mvc.command.name=/cotizacion/retroactividad",
				 },
		 service = MVCResourceCommand.class
		 )
public class ValidaRetroactividadResourceCommand extends BaseMVCResourceCommand {

	@Reference
	CotizadorService _CotizadorService;
	
	@Override
	public void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws Exception {
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
		
		HttpServletRequest originalRequest = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		int idPerfilUser = (int) originalRequest.getSession().getAttribute("idPerfil");
		User user = (User) resourceRequest.getAttribute(WebKeys.USER);
		String usuario = user.getScreenName();
		String pantalla = "Cotizaciones";
		
		int cotizacion = ParamUtil.getInteger(resourceRequest, "cotizacion");
		int version = ParamUtil.getInteger(resourceRequest, "version");
		
		RetroactividadRequest rr = new RetroactividadRequest();
		rr.setIdPerfil(idPerfilUser);
		rr.setP_cotizacion((cotizacion));
		rr.setP_version((version));
		ValidaResponse respuesta = _CotizadorService.wsValidarRetroactividad(rr, pantalla, usuario);
		String resp = "{\"msg\" : \"" + respuesta.getMsg() +"\", \"code\" : \"" + respuesta.getCode() + "\"}";
		PrintWriter writer = resourceResponse.getWriter();
		writer.write(resp);
	}

}
