package com.tokio.pa.cotizacionesportlet73.portlet;

import java.io.PrintWriter;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.MimeTypesUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.cotizador.CotizadorService;
import com.tokio.cotizador.Bean.CotizacionResponse;
import com.tokio.cotizador.Bean.SimpleResponse;
import com.tokio.pa.cotizacionesportlet73.constants.CotizacionesPortlet73PortletKeys;

@Component(
		immediate = true, 
		property = { "javax.portlet.name=" + CotizacionesPortlet73PortletKeys.PORTLET_NAME,
					 "mvc.command.name=/cotizacion/tokioAjax" },
		service = MVCResourceCommand.class
)

public class GetTokioResultMVCResourceCommand extends BaseMVCResourceCommand{

	private static final Log log = LogFactoryUtil.getLog(ConsultActionCommand.class);
	
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
		
		
		HttpServletRequest originalRequest = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		String folio = ParamUtil.getString(resourceRequest, "folioTMX");
		String poliza = ParamUtil.getString(resourceRequest, "poliza");
		String estatus = ParamUtil.getString(resourceRequest, "estatus");
		String modoCotizacion = ParamUtil.getString(resourceRequest, "modoCotizacion");
		String fechaInicio = ParamUtil.getString(resourceRequest, "fechaInicio");
		String fechaFin = ParamUtil.getString(resourceRequest, "fechaFin");
		int agente = ParamUtil.getInteger(resourceRequest, "agente");
		String asegurado = ParamUtil.getString(resourceRequest, "asegurado");
		int tipoMovimiento = ParamUtil.getInteger(resourceRequest, "tipoMovimiento");
		int moneda = ParamUtil.getInteger(resourceRequest, "moneda");
		int producto = ParamUtil.getInteger(resourceRequest, "producto");
		int ramo = ParamUtil.getInteger(resourceRequest, "ramo");
		int tipoConsulta = ParamUtil.getInteger(resourceRequest, "tipoConsulta");
		int rowNum = ParamUtil.getInteger(resourceRequest, "rowNum");
		String idSolicitud = ParamUtil.getString(resourceRequest, "idSolicitud");
		int coaseguro = ParamUtil.getInteger(resourceRequest, "coaseguro");
		User user = (User) resourceRequest.getAttribute(WebKeys.USER);
		String usuario = user.getScreenName();
		String pantalla = "Cotizaciones";
		int cliente = ParamUtil.getInteger(resourceRequest, "idPersona");
		int idPerfilUser = (int) originalRequest.getSession().getAttribute("idPerfil");
		int p_tipoConsulta = (idPerfilUser<4)?1:2;
		int tipoTmx=((idPerfilUser<4)||(idPerfilUser==25))?1:3;//tmx
		
		try{
			CotizacionResponse respuesta = cotizadorService.getCotizacion( folio,idPerfilUser,"cotizacion",poliza,
					modoCotizacion,estatus,fechaInicio, fechaFin,cliente,agente,
					moneda,producto,ramo,tipoMovimiento,tipoTmx, rowNum, idSolicitud, coaseguro, 
					usuario,pantalla);
			
			if( respuesta.getCode()==0 ){
				Gson gson = new Gson();
				String stringJson = gson.toJson(respuesta);
				resourceResponse.getWriter().write(stringJson);
			}else{
				StringBuilder stringJson = new StringBuilder();
				stringJson.append("{");
				stringJson.append("\"code\":" + respuesta.getCode() );
				stringJson.append(",\"msg\":\"" + respuesta.getMsg() + "\"" );
				stringJson.append("}");
				System.out.println( stringJson.toString() );
				resourceResponse.getWriter().write(stringJson.toString());

			}
			
		}catch(Exception e){
			log.info( e.getLocalizedMessage() );
			StringBuilder stringJson = new StringBuilder();
			stringJson.append("{");
			stringJson.append("\"code\":" + 5 );
			stringJson.append(",\"msg\":\"" +  e.getMessage() + "\"" );
			stringJson.append("}");
			System.out.println( stringJson.toString() );
			resourceResponse.getWriter().write(stringJson.toString());
		}

		
		
	}

}
