package com.tokio.pa.cotizacionesportlet73.portlet;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.util.Map;
import java.util.Map.Entry;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.apache.commons.io.IOUtils;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.upload.FileItem;
import com.liferay.portal.kernel.upload.UploadPortletRequest;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.cotizador.CotizadorService;
import com.tokio.cotizador.Bean.DocumentoResponse;
import com.tokio.pa.cotizacionesportlet73.constants.CotizacionesPortlet73PortletKeys;
import com.tokio.cotizador.util.Codifica;

@Component(
		immediate = true,
		 property = {
				 "javax.portlet.name="+ CotizacionesPortlet73PortletKeys.PORTLET_NAME,
				 "mvc.command.name=/cotizacion/uploadFiles",
				 },
		 service = MVCResourceCommand.class
		 )
public class UploadFileResourceCommand extends BaseMVCResourceCommand{
	
	@Reference
	CotizadorService _CotizadorService;
	
	@Override
	protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws Exception {
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
		
		UploadPortletRequest uploadRequest = PortalUtil.getUploadPortletRequest( resourceRequest );
        
		int idCotizacion = ParamUtil.getInteger(resourceRequest, "idCotizacion");

		Map<String, FileItem[]> files = uploadRequest.getMultipartParameterMap();
		
		BufferedInputStream in = null;
		StringBuilder builder = new StringBuilder();
		String tipo= "COTIZACIONES";
		User user = (User) resourceRequest.getAttribute(WebKeys.USER);
		String usuario = user.getScreenName();
		String pantalla = "Cotizaciones";
		String tipoTransaccion = "I";
		int idCarpeta = ParamUtil.getInteger(resourceRequest, "idCarpeta");
		int idDocumento = 0;
		int idCatalogoDetalle = 0;
		
		
		boolean first = true;
		System.out.println("antes de for");
		for (Entry<String, FileItem[]> file2 : files.entrySet()) {
			FileItem item[] =file2.getValue();			
			for( int i =0; i< item.length; i++ ){
				File f = item[i].getStoreLocation();
				in = new BufferedInputStream(new FileInputStream(f));
				if( !first ){
					builder.append(",");
				}
				
				builder.append("{");
				builder.append("\"nombre\":\"" + getFileName( item[i].getFileName() ) + "\",");
				builder.append("\"extension\":\"" + getFileExtension(f) +"\"," );
				builder.append("\"idCarpeta\":" + idCarpeta + ",");
				builder.append("\"idDocumento\":" + idDocumento+ ",");
				builder.append("\"idCatalogoDetalle\":" + idCatalogoDetalle+ ",");
				builder.append("\"documento\":\"" + Codifica.encode( IOUtils.toByteArray(in) )+ "\"");
				builder.append("}");
				first = false;
			}
		}
		System.out.println("despues de for");
		
		DocumentoResponse docResp = null; 
		System.out.println("idCotizacion:"+idCotizacion);
		System.out.println("idCarpeta:"+idCarpeta);
		docResp = _CotizadorService.wsDocumentos(0, tipoTransaccion, builder.toString(), 1, tipo, idCotizacion, "", usuario, pantalla);
		
		//pasar a string json  
		Gson gson = new Gson();
		String stringJson = gson.toJson(docResp);
		resourceResponse.getWriter().write(stringJson);
		
		
	}
	private static String getFileExtension(File file) {
        String fileName = file.getName();
        if(fileName.lastIndexOf('.') != -1 && fileName.lastIndexOf('.') != 0)
        	return fileName.substring(fileName.lastIndexOf('.')+1);
        else return "";
	}
	
	private static String getFileName(String fileName) {
        //String fileName = file.getName();
        if(fileName.lastIndexOf('.') != -1 && fileName.lastIndexOf('.') != 0)
        	return fileName.substring(0,fileName.lastIndexOf('.'));
        
        return "";
    }
}
