package com.tokio.pa.cotizacionesportlet73.portlet;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.servlet.http.HttpServletRequest;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCActionCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCActionCommand;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.cotizador.CotizadorService;
import com.tokio.cotizador.Bean.CotizacionResponse;
import com.tokio.pa.cotizacionesportlet73.constants.CotizacionesPortlet73PortletKeys;


@Component(
		 property = {
		 "javax.portlet.name="+ CotizacionesPortlet73PortletKeys.PORTLET_NAME,
		 "mvc.command.name=/pendientesTokio"
		 },
		 service = MVCActionCommand.class
		 )
public class ConsultActionCommand extends BaseMVCActionCommand {
	
	private static final Log log = LogFactoryUtil.getLog(ConsultActionCommand.class);

	@Reference
	CotizadorService cotizadorService; 
	
	@Override
	protected void doProcessAction(ActionRequest actionRequest, ActionResponse actionResponse) throws Exception {

		
		HttpServletRequest originalRequest = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(actionRequest));
		String folio = ParamUtil.getString(actionRequest, "folioTMX");
		String poliza = ParamUtil.getString(actionRequest, "poliza");
		String estatus = ParamUtil.getString(actionRequest, "estatus");
		String modoCotizacion = ParamUtil.getString(actionRequest, "modoCotizacion");
		String fechaInicio = ParamUtil.getString(actionRequest, "fechaInicio");
		String fechaFin = ParamUtil.getString(actionRequest, "fechaFin");
		int agente = ParamUtil.getInteger(actionRequest, "agente");
		String asegurado = ParamUtil.getString(actionRequest, "asegurado");
		int tipoMovimiento = ParamUtil.getInteger(actionRequest, "tipoMovimiento");
		int moneda = ParamUtil.getInteger(actionRequest, "moneda");
		int producto = ParamUtil.getInteger(actionRequest, "producto");
		int ramo = ParamUtil.getInteger(actionRequest, "ramo");
		int tipoConsulta = ParamUtil.getInteger(actionRequest, "tipoConsulta");
		int rowNum = 0;
		String idSolicitud = ParamUtil.getString(actionRequest, "idSolicitud");
		int coaseguro = ParamUtil.getInteger(actionRequest, "coaseguro");
		User user = (User) actionRequest.getAttribute(WebKeys.USER);
		String usuario = user.getScreenName();
		String pantalla = "Cotizaciones";
		int cliente = ParamUtil.getInteger(actionRequest, "idPersona");
		int idPerfilUser = (int) originalRequest.getSession().getAttribute("idPerfil");
		int p_tipoConsulta = (idPerfilUser<4)?1:2;
		int tipoTmx=((idPerfilUser<4)||(idPerfilUser==25))?1:3;//tmx
		
		if(idPerfilUser == 50) {
			tipoTmx = 4;
			p_tipoConsulta = 4;
		}

		
		
		actionRequest.setAttribute("tFolioTMX", folio );
		actionRequest.setAttribute("tPoliza", poliza );
		actionRequest.setAttribute("tEstatus", estatus );
		actionRequest.setAttribute("tModoCotizacion", modoCotizacion );
		actionRequest.setAttribute("tFechaInicio", fechaInicio );
		actionRequest.setAttribute("tFechaFin", fechaFin );
		actionRequest.setAttribute("tAgente", agente );
		actionRequest.setAttribute("tAsegurado", asegurado );
		actionRequest.setAttribute("tTipoMovimiento", tipoMovimiento );
		actionRequest.setAttribute("tMoneda", moneda );
		actionRequest.setAttribute("tProducto", producto );
		actionRequest.setAttribute("tRamo", ramo );
		actionRequest.setAttribute("tipoConsulta", tipoConsulta );
		actionRequest.setAttribute("tAseguradoId", cliente );
		

		
		
		try{
			CotizacionResponse respuesta = cotizadorService.getCotizacion( folio,idPerfilUser,"cotizacion",poliza,
					modoCotizacion,estatus,fechaInicio, fechaFin,cliente,agente,
					moneda,producto,ramo,tipoMovimiento,tipoTmx, rowNum, idSolicitud, coaseguro, usuario,pantalla);
			
			if( respuesta.getCode()==0 ){
				actionRequest.setAttribute("listaPendienteTokio", respuesta.getCotizaciones() );
				SessionMessages.add(actionRequest, "consultaExitosa");
			}else{
				actionRequest.setAttribute("errorTokio", 1);
				actionRequest.setAttribute("errorMsg",  respuesta.getMsg() );

				actionRequest.setAttribute("listaPendienteTokio", respuesta.getCotizaciones() );
				SessionErrors.add(actionRequest, "errorConocido", respuesta.getMsg() );
			}
			
		}catch(Exception e){
			log.info( e.getLocalizedMessage() );
			SessionErrors.add(actionRequest, "errorDesconocido");
		}finally {
			SessionMessages.add(actionRequest, PortalUtil.getPortletId(actionRequest) + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
		}
		
		
	}
	
	

}
