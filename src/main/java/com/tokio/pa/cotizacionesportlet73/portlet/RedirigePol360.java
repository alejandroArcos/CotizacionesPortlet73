/**
 * 
 */
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
		property = {
				"javax.portlet.name=" + CotizacionesPortlet73PortletKeys.PORTLET_NAME,
					"mvc.command.name=/list/cotizacion/redirigePasoX" 
				},
		service = MVCResourceCommand.class)
public class RedirigePol360 extends BaseMVCResourceCommand {

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
		
		JsonObject obj = new JsonObject();
		
		try {
			HttpServletRequest originalRequest = PortalUtil
					.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
			ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest
					.getAttribute(WebKeys.THEME_DISPLAY);
			
			final long GROUP_ID = themeDisplay.getLayout().getGroupId();
			Layout layout = LayoutLocalServiceUtil.getFriendlyURLLayout(GROUP_ID, true, "/administrar-póliza");
			String urlCotizador = layout.getRegularURL(originalRequest);
			
			
			String poliza = ParamUtil.getString(resourceRequest, "poliza");
			String endoso = ParamUtil.getString(resourceRequest, "endoso");
			String tpoCot = ParamUtil.getString(resourceRequest, "tipo");
			
			
				tpoCot = tpoCot.contains("1") ? "familiar" : "empresarial";
			
			
			String parametro = "?poliza=" + poliza + "&endoso=" + endoso + "&tpoCot=" + tpoCot;
			
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
