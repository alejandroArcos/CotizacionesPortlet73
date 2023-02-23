/**
 * 
 */
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

/**
 * @author jonathanfviverosmoreno
 *
 */

@Component(
		immediate = true, 
		property = { "javax.portlet.name=" + CotizacionesPortlet73PortletKeys.PORTLET_NAME,
					 "mvc.command.name=/listCotizaciones/redirige" },
		service = MVCResourceCommand.class
)
public class RedirigeResourceCommand extends BaseMVCResourceCommand {
	
	private static final Log _log = LogFactoryUtil.getLog(RedirigeResourceCommand.class);

	
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
			 
			//int tipoCotizacion = ParamUtil.getInteger(resourceRequest, "tipo");
			int idProducto = ParamUtil.getInteger(resourceRequest, "idProducto");
			int folio = ParamUtil.getInteger(resourceRequest, "folio");
			int cotizacion = ParamUtil.getInteger(resourceRequest, "cotizacion");
			int version = ParamUtil.getInteger(resourceRequest, "version");
			int modo = ParamUtil.getInteger(resourceRequest, "modo");
			boolean isEndoso = ParamUtil.getBoolean(resourceRequest, "isEndoso");
			String codEndoso = ParamUtil.getString(resourceRequest, "codEndoso");
			String polAnt = ParamUtil.getString(resourceRequest, "polAnt");
			
			System.out.println("El modo es: " + modo);
			_log.info("El modo es: " + modo);
			
			InfoCotizacion inf = new InfoCotizacion();
			
			inf.setCotizacion(cotizacion);
			inf.setFolio(folio);
			inf.setModo(seleccionaModo(modo));
			inf.setTipoCotizacion(seleccionaTipo(idProducto));
			inf.setVersion(version);
			inf.setPoliza(polAnt);
			System.out.println("------------->modo:"+inf.getModo());
			String parametro = "?infoCotizacion=" + CotizadorModularUtil.encodeURL(inf);
			String tipo = "";
			if(isRenovacion(inf.getModo())){
				tipo = "/paso3";
			}else{
				if(inf.getTipoCotizacion().equals(TipoCotizacion.EMPRESARIAL)) {
					if(idProducto == 210) {
						tipo = "/paquete-empresarial-maquetado";
					}
					else {
						tipo = "/paquete-empresarial";
					}
				}
				else {
					tipo = "/paquete-familiar";
				}
			}
			
			_log.info("idProducto : " + idProducto);
			
			switch(idProducto) {
				case CotizacionesPortlet73PortletKeys.PRODUCTO_FAMILIAR:
					tipo = "/paquete-familiar";
					break;
				case CotizacionesPortlet73PortletKeys.PRODUCTO_EMPRESARIAL:
					tipo = "/paquete-empresarial";
					break;
				case CotizacionesPortlet73PortletKeys.PRODUCTO_EMPRESARIAL_MEJORAS:
					tipo = "/property-quotation";
					break;
				case CotizacionesPortlet73PortletKeys.PRODUCTO_TRANSPORTES:
					tipo = "/cotizador-transportes";
					break;
				case CotizacionesPortlet73PortletKeys.PRODUCTO_FAMILIAR_MEJORAS:
					tipo = "/homeowner-quotation";
					break;
				case CotizacionesPortlet73PortletKeys.PRODUCTO_RC:
					tipo = "/cotizador-rc";
					break;
				case CotizacionesPortlet73PortletKeys.PRODUCTO_VIDA:
				case CotizacionesPortlet73PortletKeys.PRODUCTO_VIDA_DEUDOR:
				case CotizacionesPortlet73PortletKeys.PRODUCTO_VIDA_TUTOR:
				case CotizacionesPortlet73PortletKeys.PRODUCTO_GASTOS_FUNERARIOS:
					tipo ="/cotizador-vida";
					break;
				default:
					tipo = "/";
					break;
			}
			
			
			final long GROUP_ID = themeDisplay.getLayout().getGroupId();
			Layout layout = LayoutLocalServiceUtil.getFriendlyURLLayout(GROUP_ID, true, tipo);
			String urlCotizador = layout.getRegularURL(originalRequest);
			
			
			System.out.println("parametro : " + parametro);
			System.out.println("tipo : " + tipo);
			System.out.println("urlCotizador : " + urlCotizador);
			
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
			e.printStackTrace();
		}

	}
	
	private ModoCotizacion seleccionaModo(int modo){		
		switch (modo) {
			case 1:
				return ModoCotizacion.EDICION;
			case 2:
				return ModoCotizacion.COPIA;
			case 3:
				return ModoCotizacion.EDITAR_ALTA_ENDOSO;
			case 4:
				return ModoCotizacion.EDITAR_BAJA_ENDOSO;
			case 5:
				return ModoCotizacion.CONSULTA;
			case 6 : 
				return ModoCotizacion.EDITAR_RENOVACION_AUTOMATICA;
			case 7:
				return ModoCotizacion.CONSULTAR_RENOVACION_AUTOMATICA;
			case 8:
				return ModoCotizacion.EDICION_JAPONES;
			case 9:
				return ModoCotizacion.CONSULTAR_REVISION;
			case 10:
				return ModoCotizacion.FACTURA_492;
			default:
				return ModoCotizacion.NUEVA;
		}	
	}
	
	private TipoCotizacion seleccionaTipo(int idProducto){
		switch (idProducto) {
			case 208:
				return TipoCotizacion.FAMILIAR;
			case 209:
				return TipoCotizacion.EMPRESARIAL;
			case 210:
				return TipoCotizacion.EMPRESARIAL;
			case 211:
				return TipoCotizacion.TRANSPORTES;
			case 3148:
				return TipoCotizacion.FAMILIAR;
			case 3149:
				return TipoCotizacion.RC;
			case 836:
			case 7728:
			case 7729:
			case 7730:
				return TipoCotizacion.VIDA;
			default:
				return TipoCotizacion.ERROR;
		}
	}
	
	private boolean isRenovacion(ModoCotizacion modo){
		switch (modo) {
			case RENOVACION_AUTOMATICA:
				return true;
			case EDITAR_RENOVACION_AUTOMATICA:
				return true;
			case CONSULTAR_RENOVACION_AUTOMATICA:
				return true;
			default:
				return false;
		}
	}

}
