package com.tokio.pa.cotizacionesportlet73.portlet;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.cotizador.CotizadorService;
import com.tokio.cotizador.Bean.CotizacionResponse;
import com.tokio.cotizador.Bean.Persona;
import com.tokio.cotizador.Bean.Registro;
import com.tokio.cotizador.constants.CotizadorServiceKey;
import com.tokio.pa.cotizacionesportlet73.constants.CotizacionesPortlet73PortletKeys;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

/**
 * @author urielfloresvaldovinos
 */
@Component(
	immediate = true,
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=CotizacionesPortlet73",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + CotizacionesPortlet73PortletKeys.PORTLET_NAME,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user",
		"com.liferay.portlet.private-session-attributes=false",
		"com.liferay.portlet.requires-namespaced-parameters=false",
		"com.liferay.portlet.private-request-attributes=false"
	},
	service = Portlet.class
)
public class CotizacionesPortlet73Portlet extends MVCPortlet {
	private static final Log _log = LogFactoryUtil.getLog(CotizacionesPortlet73Portlet.class);
	@Reference
	CotizadorService cotizadorService; 
	
	@SuppressWarnings("unchecked")
	@Override
	public void doView( RenderRequest renderRequest, RenderResponse renderResponse) 
			throws IOException, PortletException {
		HttpServletRequest originalRequest = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
		int rowNum = 0;
		String transaccion = "B";
		int active = 1;
		User user = (User) renderRequest.getAttribute(WebKeys.USER);
		String usuario = user.getScreenName();
		String pantalla = "Cotizaciones";
		int idPerfilUser = (int) originalRequest.getSession().getAttribute("idPerfil");
		int p_tipoConsulta = (idPerfilUser<4)?1:2;
		
		Integer tipoConsulta =(Integer) renderRequest.getAttribute("tipoConsulta" );
		if( Validator.isNull(tipoConsulta) ){
			HttpServletRequest orig = PortalUtil.getOriginalServletRequest( PortalUtil.getHttpServletRequest(renderRequest) );
			String filtro = ""+orig.getParameter("tipoConsulta");
			if( Validator.isNull(filtro) ){
				filtro = "1";
			}
			tipoConsulta = Integer.parseInt(filtro);
			renderRequest.setAttribute("tipoConsulta" , tipoConsulta);
			
		}


		try {
			
			List<Registro> estatus = cotizadorService.getCatalogo(rowNum,transaccion, CotizadorServiceKey.LISTA_ESTADO_COTIZACION ,active,usuario,pantalla);
			List<Registro> modoCotizacion = cotizadorService.getCatalogo(rowNum,transaccion, CotizadorServiceKey.MODO_COTIZACION ,active,usuario,pantalla);
			List<Registro> tipoMovimiento = cotizadorService.getCatalogo(rowNum,transaccion, CotizadorServiceKey.TIPO_MOVIMIENTO ,active,usuario,pantalla);
			List<Registro> moneda = cotizadorService.getCatalogo(rowNum,transaccion, CotizadorServiceKey.LISTA_MONEDA ,active,usuario,pantalla);
			List<Registro> producto = cotizadorService.getCatalogo(rowNum,transaccion, CotizadorServiceKey.LISTA_PRODUCTO ,active,usuario,pantalla);
			List<Registro> ramo = cotizadorService.getCatalogo(rowNum,transaccion, CotizadorServiceKey.LISTA_RAMO ,active,usuario,pantalla);
			List<Registro> tipoRechazo = cotizadorService.getCatalogo(rowNum,transaccion, CotizadorServiceKey.TIPO_MOTIVO_RECHAZO ,active,usuario,pantalla);
			List<Registro> tipoCoaseguro = cotizadorService.getCatalogo(rowNum,transaccion, CotizadorServiceKey.CAT_TIP_COASEGURO ,active,usuario,pantalla);
			List<Registro> tipoEndoso = cotizadorService.getCatalogo(rowNum,transaccion, CotizadorServiceKey.CAT_TIP_ENDOSO ,active,usuario,pantalla);
			List<Registro> canalNegocio = cotizadorService.getCatalogo(rowNum,transaccion, CotizadorServiceKey.CAT_CANAL_NEG_SA ,active,usuario,pantalla);
			
			//Integer idUsuario = (Integer)originalRequest.getSession().getAttribute("idUsuario");
			List<Persona> persona = (List<Persona>) originalRequest.getSession().getAttribute("listaAgentes");
			
			/*idPerfilUser = 4;*/
			
//			List<Persona> persona = cotizadorService.getListaAgenteUsuario(idUsuario, usuario, pantalla);
				
			renderRequest.setAttribute("listaEstatus", estatus);
			renderRequest.setAttribute("listaModo", modoCotizacion);
			renderRequest.setAttribute("listaTipoMovimiento", tipoMovimiento);
			renderRequest.setAttribute("listaMoneda", moneda);
			renderRequest.setAttribute("listaProducto", producto);
			renderRequest.setAttribute("listaRamo", ramo);
			renderRequest.setAttribute("listaAgente", persona);
			renderRequest.setAttribute("tipoRechazo", tipoRechazo);
			renderRequest.setAttribute("tipoCoaseguro", tipoCoaseguro);
			renderRequest.setAttribute("tipoEndoso", tipoEndoso);
			renderRequest.setAttribute("canalNegocio", canalNegocio);
			renderRequest.setAttribute("idPerfilUser", idPerfilUser);
			
			
		} catch (Exception e) {
			System.out.println("---------------------------------------------------");
			System.out.println("---------------------------------------------------");
			e.printStackTrace();
			SessionErrors.add(renderRequest, "errorDesconocido" );		
		}
		Object listaPendienteAgente =renderRequest.getAttribute("listaPendienteAgente" );
		Object listaPendienteTokio =renderRequest.getAttribute("listaPendienteTokio" );
		Object errorTokio =renderRequest.getAttribute("errorTokio" );
		Object errorAgente =renderRequest.getAttribute("errorAgente" );
		
		
		Date fecha = new Date();
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		String fechaFin = format.format(fecha);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(fecha); 
		calendar.add(Calendar.DAY_OF_YEAR, -30); 
		Date fechaI = calendar.getTime(); 
		String fechaInicio = format.format(fechaI);
		
		int tipoTmx= ((idPerfilUser<4)||(idPerfilUser==25))?1:3;//tmx
		int tipoAgente= ((idPerfilUser<4)||(idPerfilUser==25))?2:3;//agente
		
		if(idPerfilUser == 50) {
			tipoTmx = 4;
			tipoAgente = 4;
		}
		
		if( Validator.isNull( listaPendienteTokio ) && Validator.isNull( errorTokio ) ){
			try{
				CotizacionResponse respuesta = cotizadorService.getCotizacion( "",idPerfilUser,"","",
						"","",fechaInicio, fechaFin,0,0,
						0,0,0,0,tipoTmx, 0, "", 0, usuario,pantalla);				
				if( respuesta.getCode()==0 ){
					
					renderRequest.setAttribute("listaPendienteTokio", respuesta.getCotizaciones() );
					System.out.println("busco lista en doView listaPendienteTokio");
				}else{
					renderRequest.setAttribute("error", 1);
					renderRequest.setAttribute("errorMsg",  respuesta.getMsg() );
					SessionErrors.add(renderRequest, "errorConocido", respuesta.getMsg() );

				}
				renderRequest.setAttribute("tFechaInicio", fechaInicio );
				renderRequest.setAttribute("tFechaFin", fechaFin );

			}catch(Exception e){
				e.printStackTrace();
				SessionErrors.add(renderRequest, "errorDesconocido" );
			}finally {
				SessionMessages.add(renderRequest, PortalUtil.getPortletId(renderRequest) + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			}

			
		}
		
		
		if(  Validator.isNull( listaPendienteAgente ) && Validator.isNull( errorAgente )  ){
			
			try{
				CotizacionResponse respuesta = cotizadorService.getCotizacion( "",idPerfilUser,"","",
						"","",fechaInicio, fechaFin,0,0,
						0,0,0,0,tipoAgente, 0, "", 0, usuario,pantalla);		
				

				System.out.println("busco lista en doView listaPendienteAgente");
				
				if( respuesta.getCode()==0 ){
					renderRequest.setAttribute("listaPendienteAgente", respuesta.getCotizaciones() );
				}else{
					renderRequest.setAttribute("error", 1);
					renderRequest.setAttribute("errorMsg",  respuesta.getMsg() );
					SessionErrors.add(renderRequest, "errorConocido",respuesta.getMsg() );
				}
				
			}catch(Exception e){
				e.printStackTrace();
				System.out.println("error");
				System.out.println( e.getLocalizedMessage() );
				SessionErrors.add(renderRequest, "errorDesconocido" );
			}finally {
				SessionMessages.add(renderRequest, PortalUtil.getPortletId(renderRequest) + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			}
			renderRequest.setAttribute("aFechaInicio", fechaInicio );
			renderRequest.setAttribute("aFechaFin", fechaFin );

			
		}

			
		System.out.println("llamo a super");
		super.doView(renderRequest, renderResponse);
		HttpSession httpSession = PortalUtil.getHttpServletRequest(renderRequest).getSession();
	}
}