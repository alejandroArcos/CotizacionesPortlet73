<%@ include file="./init.jsp"%>

<liferay-portlet:actionURL name="/pendientesTokio" var="pendientesTokio">
	<portlet:param name="tipoConsulta" value="1" />
</liferay-portlet:actionURL>

<liferay-portlet:actionURL name="/pendientesAgente" var="pendientesAgente">
	<portlet:param name="tipoConsulta" value="2" />
</liferay-portlet:actionURL>

<portlet:resourceURL id="/cotizacion/searchPerson" var="searchPersonURL"/>

<portlet:resourceURL id="/cotizacion/uploadFiles" var="uploadFilesURL"/>

<portlet:resourceURL id="/cotizacion/descargarDocumento" var="descargarDocumento"/>

<portlet:resourceURL id="/cotizacion/solicitarEmision" var="solicitarTmx"/>

<portlet:resourceURL id="/list/cotizacion/redirigePasoX" var="redirige360URL"/>

<%--  Paginacion --%>

<portlet:resourceURL id="/cotizacion/pendientesAjax" var="agentesAjax"/>

<portlet:resourceURL id="/cotizacion/tokioAjax" var="tokioAjax"/>

<%-- Url de botones Tokio --%>
<portlet:resourceURL id="/cotizacion/obtieneArchivos" var="datosArchivos"/>
<portlet:resourceURL id="/cotizacion/obtieneMensajes" var="datosMensajes"/>
<portlet:resourceURL id="/cotizacion/guardaComentario" var="saveComentarioURL"/>
<portlet:resourceURL id="/cotizacion/revire" var="revire"/>
<portlet:resourceURL id="/cotizacion/rechazoCotizacion" var="rechazoCotizacion"/>
<portlet:resourceURL id="/listCotizaciones/redirige" var="redirigeURL"/>
<portlet:resourceURL id="/listCotizaciones/redirigeSolicitud" var="redirigeSolicitudURL"/>


<liferay-ui:success key="consultaExitosa" message="cotizacion.exito" />
<liferay-ui:error key="errorConocido" message=" ${errorMsg}" />
<liferay-ui:error key="errorDesconocido" message="cotizacion.erorDesconocido" />

<c:set var="permisoEmision" value="<%=RoleLocalServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(),\"TMX-EMISION EN LISTADO DE COTIZACIONES\", false)%>" />


<c:set var="enCotizacionRev" value="331" property="EN COTIZACION DE REVIRE" />
<c:set var="masDatos" value="359" property="SE NECESITAN MAS DATOS" />
<c:set var="enCotizacion" value="330" property="EN COTIZACION" />
<c:set var="art492bv" value="351" property="ART. 492 Vo. Bo." />
<c:set var="noAceptada" value="349" property="NO ACEPTADO" />
<c:set var="enEmision" value="360" property="EN EMISION" />
<c:set var="rechazada" value="329" property="RECHAZADA" />
<c:set var="captura" value="310" property="EN CAPTURA" />
<c:set var="revision" value="320" property="REVISION" />
<c:set var="cotizado" value="340" property="COTIZADO" />
<c:set var="emitido" value="370" property="EMITIDO" />
<c:set var="art492" value="350" property="ART. 492" />

<c:set var="idProductoEmpresarial" value="209" />
<c:set var="idProductoFamiliar" value="208" />
<c:set var="idProductoManual" value="783" />
<c:set var="modoManual" value="MANUAL" />
<c:set var="modoWeb" value="WEB" />
<c:set var="modoSA" value="SA" />


<div style="display: none;">
	<input type="hidden" id="rechazoCotizacionURL" value="${rechazoCotizacion}">
	<input type="hidden" id="datosMensajesURL" value="${datosMensajes}">
	<input type="hidden" id="saveComentarioURL" value="${saveComentarioURL}">
	<input type="hidden" id="datosArchivosURL" value="${datosArchivos}">
	<input type="hidden" id="solicitarTmxURL" value="${solicitarTmx}">
	<input type="hidden" id="revireURL" value="${revire}">
</div>

<div id="customAlertJS"></div>
<section class="upper-case-all">
	<div class="section-heading">
		<div class="container-fluid">
			<h1 class="title text-left">
				<liferay-ui:message key="CotizacionesPortlet.titulo.consulta" />
				<!-- 				V 1.1 -->
			</h1>
		</div>
	</div>
	<div class="section-nav-wrapper">
		<ul class="nav nav-tabs md-tabs nav-justified light-blue darken-4" role="tablist">
			<c:if test="${tipoConsulta == 1}">
				<c:set var="activePendiente" value="active" />
				<c:set var="activeTokio" value="" />
			</c:if>
			<c:if test="${tipoConsulta == 2}">
				<c:set var="activePendiente" value="" />
				<c:set var="activeTokio" value="active" />
			</c:if>

			<li class="nav-item ">
				<a class="nav-link ${activePendiente}" data-toggle="tab" href="#pendientes-tokio" role="tab">
					<liferay-ui:message key="CotizacionesPortlet.pendientes.tokio" />
				</a>
			</li>
			<li class="nav-item ">
				<a class="nav-link ${activeTokio }" data-toggle="tab" href="#pendientes-agente" role="tab">
					<liferay-ui:message key="CotizacionesPortlet.pendientes.agente" />
				</a>
			</li>
		</ul>
	</div>
	<div class="tab-content">

		<c:if test="${tipoConsulta == 1}">
			<c:set var="activePendiente" value="in active" />
			<c:set var="activeTokio" value="" />
		</c:if>
		<c:if test="${tipoConsulta == 2}">
			<c:set var="activePendiente" value="" />
			<c:set var="activeTokio" value="in active" />
		</c:if>

		<!--Panel 1-->
		<div class="tab-pane ${ activePendiente }" id="pendientes-tokio" role="tabpanel">
			<div class="form-wrapper">
				<form id="search-form" class="mb-4" action="<%=pendientesTokio%>" method="POST">
					<div class="row">
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<input id="folioTMX" type="text" name="<portlet:namespace/>folioTMX" value="${tFolioTMX }" class="form-control">
								<label for="folioTMX">
									<liferay-ui:message key="CotizacionesPortlet.folioTmx" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<c:if test="${ idPerfilUser !=  8 && idPerfilUser != 26}">
								<div class="md-form form-group">
									<input id="Apoliza" type="text" name="<portlet:namespace/>poliza" value="${aPoliza }" class="form-control">
									<label for="Apoliza">
										<liferay-ui:message key="CotizacionesPortlet.poliza" />
									</label>
								</div>
							</c:if>
							<c:if test="${ idPerfilUser ==  8 || idPerfilUser == 26}">
								<div class="row">
									<div class="col">
										<div class="md-form form-group">
									<input id="Apoliza" type="text" name="<portlet:namespace/>poliza" value="${aPoliza }" class="form-control">
									<label for="Apoliza">
										<liferay-ui:message key="CotizacionesPortlet.poliza" />
									</label>
								</div>
									</div>
									<div class="col">
										<div class="md-form form-group">
											<input id="idSolicitud" type="text" name="<portlet:namespace/>idSolicitud" value="${aSolicitud }" class="form-control">
											<label for="idSolicitud">
												<liferay-ui:message key="CotizacionesPortlet.solicitud" />
											</label>
										</div>
									</div>
								</div>
							</c:if>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>estatus" id="<portlet:namespace/>estatus" class="mdb-select">
									<option value="0">
										<liferay-ui:message key="CotizacionesPortlet.titulo.all" />
									</option>
									<c:forEach items="${listaEstatus}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == tEstatus}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>

								</select>
								<label for="<portlet:namespace/>estatus">
									<liferay-ui:message key="CotizacionesPortlet.estatus" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>modoCotizacion" id="<portlet:namespace/>modoCotizacion" class="mdb-select">
									<option value="0">Todos</option>
									<c:forEach items="${listaModo}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == tModoCotizacion}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>modoCotizacion">
									<liferay-ui:message key="CotizacionesPortlet.modoCotizacion" />
								</label>
							</div>
						</div>
					</div>
					<div class="row">


						<div class="col-sm-6 col-lg-3">
							<!--div class="md-form form-group">
								<label for="modoCotizacion" class="active"> Creaci&oacute;n de la cotizaci&oacute;n Inicio </label>
								<div class="col">
									<input placeholder="Desde" type="text" id="fechaITokio" value="${tFechaInicio }" name="<portlet:namespace/>fechaInicio" id="creationDate" class="form-control datepicker">
								</div>
							</div-->
							<div id="date-fechaITokio" class="md-form md-outline input-with-post-icon datepicker">
		                      <input id="fechaITokio" placeholder="Desde" name="<portlet:namespace/>fechaInicio" type="text" class="form-control" value="${tFechaInicio }">
		                      <label for="fechaITokio">Creaci&oacute;n de la cotizaci&oacute;n Inicio</label>
		                      <i class="fas fa-calendar input-prefix" tabindex=0></i>
		                    </div>
						</div>

						<div class="col-sm-6 col-lg-3">
							<!--div class="md-form form-group">
								<label for="modoCotizacion" class="active"> Creaci&oacute;n de la cotizaci&oacute;n Fin </label>
								<div class="col">
									<input placeholder="Hasta" type="text" id="fechaFTokio" value="${tFechaFin }" name="<portlet:namespace/>fechaFin" class="form-control datepicker">
								</div>
							</div-->
							
							<div id="date-fechaFTokio" class="md-form md-outline input-with-post-icon datepicker">
		                      <input id="fechaFTokio" placeholder="Hasta" name="<portlet:namespace/>fechaFin" type="text" class="form-control" value="${tFechaFin }">
		                      <label for="fechaFTokio">Creaci&oacute;n de la cotizaci&oacute;n Fin</label>
		                      <i class="fas fa-calendar input-prefix" tabindex=0></i>
		                    </div>
							
						</div>


						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>agente" id="<portlet:namespace/>agente" class="mdb-select colorful-select dropdown-primary" searchable='<liferay-ui:message key="ModuloComisionesPortlet.buscar" />'>
									<c:if test="${fn:length(listaAgente) > 1}">
										<option value="0">
											<liferay-ui:message key="CotizacionesPortlet.titulo.all" />
										</option>
									</c:if>

									<c:forEach items="${listaAgente}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idPersona == tAgente}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idPersona}" ${estatusAnterior }>${opc.nombre}${opc.appPaterno}${opc.appMaterno}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>agente">
									<liferay-ui:message key="CotizacionesPortlet.agente" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<input type="text" id="tAsegurado" name="<portlet:namespace/>asegurado" value="${tAsegurado }" class="form-control">
								<input type="hidden" id="tAseguradoId" name="<portlet:namespace/>idPersona" value="${tAseguradoId }" class="form-control">
								<label for="tAsegurado">
									<liferay-ui:message key="CotizacionesPortlet.asegurado" />
								</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>tipoMovimiento" id="<portlet:namespace/>tipoMovimiento" class="mdb-select">
									<option value="0">
										<liferay-ui:message key="CotizacionesPortlet.titulo.all" />
									</option>
									<c:forEach items="${listaTipoMovimiento}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == tTipoMovimiento}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>tipoMovimiento">
									<liferay-ui:message key="CotizacionesPortlet.tipoMovimiento" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>moneda" id="<portlet:namespace/>moneda" class="mdb-select">
									<option value="0">
										<liferay-ui:message key="CotizacionesPortlet.titulo.all2" />
									</option>
									<c:forEach items="${listaMoneda}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == tMoneda}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>moneda">
									<liferay-ui:message key="CotizacionesPortlet.moneda" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>producto" id="<portlet:namespace/>producto" class="mdb-select">
									<option value="0">Todos</option>
									<c:forEach items="${listaProducto}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == tProducto}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>producto">
									<liferay-ui:message key="CotizacionesPortlet.producto" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>ramo" id="<portlet:namespace/>ramo" class="mdb-select">
									<option value="0">Todos</option>
									<c:forEach items="${listaRamo}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == tRamo}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>ramo">
									<liferay-ui:message key="CotizacionesPortlet.ramo" />
								</label>
							</div>
						</div>
					</div>
					<c:if test="${ idPerfilUser ==  8 || idPerfilUser == 26}">
						<div class="row">
							<div class="col-sm-6 col-lg-3">
								<div class="md-form form-group">
									<select name="<portlet:namespace/>coaseguro" id="<portlet:namespace/>coaseguro" class="mdb-select">
										<option value="0">Todos</option>
										<c:forEach items="${tipoCoaseguro}" var="opc">
											<c:set var="estatusAnterior" value="" />
											<c:if test="${opc.idCatalogoDetalle == tCoaseguro}">
												<c:set var="estatusAnterior" value="selected" />
											</c:if>
											<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
										</c:forEach>
									</select>
									<label for="<portlet:namespace/>coaseguro">
										<liferay-ui:message key="CotizacionesPortlet.coaseguro" />
									</label>
								</div>
							</div>
							<div class="col-sm-6 col-lg-3">
								<div class="md-form form-group">
									<select name="<portlet:namespace/>canalNegocio" id="<portlet:namespace/>canalNegocio" class="mdb-select">
										<option value="0">Todos</option>
										<c:forEach items="${canalNegocio}" var="opc">
											<c:set var="estatusAnterior" value="" />
											<c:if test="${opc.idCatalogoDetalle == canalNeg}">
												<c:set var="estatusAnterior" value="selected" />
											</c:if>
											<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
										</c:forEach>
									</select>
									<label for="<portlet:namespace/>canalNegocio">
										<liferay-ui:message key="CotizacionesPortlet.canalNegocio" />
									</label>
								</div>
							</div>
							<div class="col-sm-6 col-lg-3">
								<div class="md-form form-group">
									<select name="<portlet:namespace/>endoso" id="<portlet:namespace/>endoso" class="mdb-select">
										<option value="0">Todos</option>
										<c:forEach items="${tipoEndoso}" var="opc">
											<c:set var="estatusAnterior" value="" />
											<c:if test="${opc.idCatalogoDetalle == tEndoso}">
												<c:set var="estatusAnterior" value="selected" />
											</c:if>
											<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
										</c:forEach>
									</select>
									<label for="<portlet:namespace/>endoso">
										<liferay-ui:message key="CotizacionesPortlet.endoso" />
									</label>
								</div>
							</div>
						</div>
					</c:if>
					<div class="row">
						<div class="col-md-12">
							<button class="btn btn-pink float-right">
								<liferay-ui:message key="CotizacionesPortlet.buscar" />
							</button>
						</div>
					</div>
				</form>
			</div>
			<div class="table-wrapper">
				<table class="table data-table table-striped table-bordered tablaTokio" style="width: 100%;">
					<thead>
						<tr>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.folio" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.fechaCreacion" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.modoCotizacion" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.estatusTable" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.producto" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.aseguradoTable" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.agenteTable" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.monedaTable" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.ramoTable" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.movimiento" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.poliza" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.endoso" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.prima" />
							</th>
							<th>Usuario Cotiza</th>
							<th>Usuario Emite</th>
							<th class="all" data-orderable="false"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listaPendienteTokio}" var="pendiente">
							<tr>
								<td>${ pendiente.folio }</td>
								<td class="fecha">${ pendiente.fechaCreacion }</td>
								<td>${ pendiente.modo }</td>
								<td>${ pendiente.estado }</td>
								<td>${ pendiente.producto }</td>
								<td>${ pendiente.asegurado }</td>
								<td>${ pendiente.agente }</td>
								<td>${ pendiente.moneda }</td>
								<td>${ pendiente.ramo }</td>
								<td>${ pendiente.tipoMovimiento }</td>
								<td>${ pendiente.poliza }</td>
								<td>${ pendiente.endoso }</td>
								<td>${ pendiente.prima }</td>
								<td>${ pendiente.usrCotiza }</td>
								<td>${ pendiente.usrEmite }</td>
								<td>
									<div class="actions-container dropleft">
										<button type="button" class="btn btn-outline-pink dropdown-menu-right px-3 py-2 waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<i class="fa fa-ellipsis-v" aria-hidden="true"></i>
										</button>
										<div class="dropdown-menu animated fadeIn">

											<!-- Validacion para las solicitudes web -->
											<!-- idProducto -> paquete familiar 1, empresarial 2 -->
											<c:if test="${ pendiente.modo == modoManual }">
												<c:set var="folio" value="${pendiente.folio}" scope="request" />
												<c:set var="rfc" value="${pendiente.rfc}" scope="request" />
												<c:set var="cotizacion" value="${pendiente.cotizacion}" scope="request" />
												<c:set var="endoso" value="${pendiente.endoso}" scope="request" />
												<c:set var="idCarpeta" value="${pendiente.idCarpeta}" scope="request" />
												<c:set var="estado" value="${pendiente.estado}" scope="request" />
												<c:set var="version" value="${pendiente.version}" scope="request" />
												<c:set var="solicitud" value="${pendiente.noSolicitud}" scope="request" />
												<c:set var="descProd" value="${pendiente.producto}" scope="request" />
												<c:set var="tipo" value="3" scope="request" />

												<jsp:include page="botones/btnConsultarSolicitud.jsp" />
											</c:if>
											<c:if test="${ pendiente.modo == modoWeb }">
												<c:set var="tipoCot" value="${ pendiente.idProducto == idProductoFamiliar ? 1 : 2 }" scope="request" />
												<c:set var="folio" value="${pendiente.folio}" scope="request" />
												<c:set var="cotizacion" value="${pendiente.cotizacion}" scope="request" />
												<c:set var="version" value="${pendiente.version}" scope="request" />
												<c:set var="rechazoCotizacion" value="${rechazoCotizacion}" scope="request" />
												<c:set var="poliza" value="${pendiente.poliza}" scope="request" />
												<c:set var="endoso" value="${pendiente.endoso}" scope="request" />
												<c:set var="idProducto" value="${ pendiente.idProducto }" scope="request" />
												<c:set var="tipo" value="1" scope="request" />

												<c:choose>
													<c:when test="${ fn:containsIgnoreCase(pendiente.tipoMovimiento, 'SEGURO NUEVO') }">
														<c:set var="isEndoso" value="${ false }" scope="request" />
														<!-- ESCENARIO1: LA COTIZACI&Oacute;N ES INICIADA POR EL PERFIL AGENTE / EJECUTIVO SIN PASAR POR EL PERFIL DE SUSCRIPTOR -->
														<c:if test="${ (pendiente.suscripcion == 0) && (pendiente.cotizosuscriptor == 0)}">
															<c:choose>
																<c:when test="${pendiente.idEstado == captura}">
																	<jsp:include page="botones/btnEditar.jsp" />
																	<jsp:include page="botones/btnCopiar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == revision}">
																	<jsp:include page="botones/btnConsultarRevision.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacion}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacionRev}">
																	<jsp:include page="botones/btnConsultar.jsp" />

																</c:when>
																<c:when test="${pendiente.idEstado == cotizado}">
																	<jsp:include page="botones/btnCopiar.jsp" />
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == rechazada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == noAceptada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492}">
																	<jsp:include page="botones/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492bv}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == masDatos}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enEmision}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == emitido}">
																	<jsp:include page="botones/btnPoliza360.jsp" />
																</c:when>
															</c:choose>
														</c:if>

														<!-- ESCENARIO 3: LA COTIZACI&Oacute;N ES INICIADA POR EL PERFIL AGENTE / EJECUTIVO, EXCEDE SUS CAPACIDADES  Y ENVIA LA COTIZACI&Oacute;N AL PERFIL DE SUSCRIPTOR.
AMBOS PERFILES DEBEN PODER VER LA COTIZACI&Oacute;N EN SU LISTADO DE COTIZACIONES -->
														<c:if test="${ (pendiente.suscripcion == 1) && (pendiente.cotizosuscriptor == 0)}">
															<c:choose>
																<c:when test="${pendiente.idEstado == captura}">
																	<jsp:include page="botones/btnEditar.jsp" />
																	<jsp:include page="botones/btnCopiar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == revision}">
																	<jsp:include page="botones/btnConsultarRevision.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacion}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacionRev}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == cotizado}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == rechazada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == noAceptada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492bv}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == masDatos}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enEmision}">
																	<!-- sin botones -->
																</c:when>
																<c:when test="${pendiente.idEstado == emitido}">
																	<jsp:include page="botones/btnPoliza360.jsp" />
																</c:when>
															</c:choose>
														</c:if>
													</c:when>
													<c:when test="${ fn:containsIgnoreCase(pendiente.tipoMovimiento, 'ENDOSO') }">
														<c:set var="isEndoso" value="${ true }" scope="request" />
														<c:set var="codEndoso" value="${ pendiente.codigoEndoso }" scope="request" />

														<!-- ESCENARIO1: LA COTIZACI&Oacute;N ES INICIADA POR EL PERFIL AGENTE / EJECUTIVO SIN PASAR POR EL PERFIL DE SUSCRIPTOR -->
														<c:if test="${ (pendiente.suscripcion == 0) && (pendiente.cotizosuscriptor == 0)}">
															<c:choose>
																<c:when test="${pendiente.idEstado == captura}">
																	<jsp:include page="botones/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == revision}">
																	<jsp:include page="botones/btnConsultarRevision.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacion}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacionRev}">
																	<jsp:include page="botones/btnConsultar.jsp" />

																</c:when>
																<c:when test="${pendiente.idEstado == cotizado}">
																	<jsp:include page="botones/btnEditar.jsp" />
																	<jsp:include page="botones/btnRechazar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == rechazada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == noAceptada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492}">
																	<jsp:include page="botones/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492bv}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == masDatos}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enEmision}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == emitido}">
																	<jsp:include page="botones/btnPoliza360.jsp" />
																</c:when>
															</c:choose>
														</c:if>


														<!-- ESCENARIO 3: LA COTIZACI&Oacute;N ES INICIADA POR EL PERFIL AGENTE / EJECUTIVO, EXCEDE SUS CAPACIDADES  Y ENVIA LA COTIZACI&Oacute;N AL PERFIL DE SUSCRIPTOR.
AMBOS PERFILES DEBEN PODER VER LA COTIZACI&Oacute;N EN SU LISTADO DE COTIZACIONES -->
														<c:if test="${ (pendiente.suscripcion == 1) && (pendiente.cotizosuscriptor == 0)}">
															<c:choose>
																<c:when test="${pendiente.idEstado == captura}">
																	<jsp:include page="botones/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == revision}">
																	<jsp:include page="botones/btnConsultarRevision.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacion}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacionRev}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == cotizado}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == rechazada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == noAceptada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492bv}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == masDatos}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enEmision}">
																	<!-- sin botones -->
																</c:when>
																<c:when test="${pendiente.idEstado == emitido}">
																	<jsp:include page="botones/btnPoliza360.jsp" />
																</c:when>
															</c:choose>
														</c:if>

													</c:when>
													
													<c:when test="${ fn:containsIgnoreCase(pendiente.tipoMovimiento, 'RENOVACION') }">
														<!-- ESCENARIO 1:  RENOVACI&Oacute;N AUTOM&Aacute;TICA -->
														<!--  La cotizaci&oacute;n de renovaci&oacute;n es solicitada por el perfil de agente ejecutivo el ESTADO de la P&oacute;liza es -->
														<c:if test="${ (pendiente.suscripcion == 0) && (pendiente.cotizosuscriptor == 0)}">
														<c:set var="polizaAnt" value="${pendiente.polizaAnterior}" scope="request" />
															<c:choose>
																<c:when test="${pendiente.idEstado == captura}">
																	<jsp:include page="botones/Renovacion/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == revision}">
																	<!-- Sin Botones -->
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacion}">
																	<jsp:include page="botones/Renovacion/btnEditar.jsp" />
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacionRev}">
																	<!-- Sin Botones -->
																</c:when>
																<c:when test="${pendiente.idEstado == cotizado}">
																	<jsp:include page="botones/Renovacion/btnEditar.jsp" />
																	<jsp:include page="botones/btnRechazar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == rechazada}">
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == noAceptada}">
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492}">
																	<jsp:include page="botones/Renovacion/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492bv}">
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == masDatos}">
																	<jsp:include page="botones/Renovacion/btnEditar.jsp" />
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enEmision}">
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == emitido}">
																	<jsp:include page="botones/btnPoliza360.jsp" />
																</c:when>
															</c:choose>
														</c:if>

													</c:when>
												</c:choose>
											</c:if>

											<a class="dropdown-item" data-toggle="modal" href="#modal-messages"
												onclick="verMensajes('<%= datosMensajes %>', '<%= saveComentarioURL %>','${ pendiente.folio }','${ pendiente.poliza }','${ pendiente.cotizacion }','${ pendiente.endoso }','${ pendiente.version }', ${tipo} )">
												<i class="far fa-comment mr-2"></i>
												<span>
													<liferay-ui:message key="CotizacionesPortlet.mensajes" />
												</span>
											</a>
											<a class="dropdown-item" data-toggle="modal" href="#modal-archives"
												onclick="verArchivos('<%= datosArchivos %>','${ pendiente.idCarpeta}','${ pendiente.cotizacion }','${ pendiente.estado }')">
												<i class="far fa-file-alt mr-2"></i>
												<span>
													<liferay-ui:message key="CotizacionesPortlet.verArchivos" />
												</span>
											</a>
											<a class="dropdown-item" data-toggle="modal" href="#modal-short-help" onclick="">
												<i class="fas fa-question mr-2"></i>
												<span>
													<liferay-ui:message key="CotizacionesPortlet.ayuda" />
												</span>
											</a>
										</div>
									</div>


								</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>
		</div>
		<!--/Panel 1-->
		<!--Panel 2-->
		<div class="tab-pane  ${ activeTokio }" id="pendientes-agente" role="tabpanel">
			<div class="form-wrapper">
				<form id="search-form" class="mb-4" action="<%=pendientesAgente%>" method="POST">
					<div class="row">
						<div class="col-sm-6 col-lg-3">
							<div class="row">
								<div class="col">
									<div class="md-form form-group">
										<input id="folioTMXA" type="text" name="<portlet:namespace/>folioTMX" value="${aFolioTMX }" class="form-control">
										<label for="folioTMXA">
											<liferay-ui:message key="CotizacionesPortlet.folioTmx" />
										</label>
									</div>
								</div>
								<div class="col">
									<div class="md-form form-group">
										<input id="idCotizador" type="text" name="<portlet:namespace/>idCotizador" value="${aCotizacion }" class="form-control">
										<label for="idCotizador">
											<liferay-ui:message key="CotizacionesPortlet.cotizador" />
										</label>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<c:if test="${ idPerfilUser !=  8 && idPerfilUser != 26}">
								<div class="md-form form-group">
									<input id="Apoliza" type="text" name="<portlet:namespace/>poliza" value="${aPoliza }" class="form-control">
									<label for="Apoliza">
										<liferay-ui:message key="CotizacionesPortlet.poliza" />
									</label>
								</div>
							</c:if>
							<c:if test="${ idPerfilUser ==  8 || idPerfilUser == 26}">
								<div class="row">
									<div class="col">
										<div class="md-form form-group">
									<input id="Apoliza" type="text" name="<portlet:namespace/>poliza" value="${aPoliza }" class="form-control">
									<label for="Apoliza">
										<liferay-ui:message key="CotizacionesPortlet.poliza" />
									</label>
								</div>
									</div>
									<div class="col">
										<div class="md-form form-group">
											<input id="idSolicitud" type="text" name="<portlet:namespace/>idSolicitud" value="${aSolicitud }" class="form-control">
											<label for="idSolicitud">
												<liferay-ui:message key="CotizacionesPortlet.solicitud" />
											</label>
										</div>
									</div>
								</div>
							</c:if>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>estatus" id="<portlet:namespace/>estatusA" class="mdb-select">
									<option value="0">
										<liferay-ui:message key="CotizacionesPortlet.titulo.all" />
									</option>
									<c:forEach items="${listaEstatus}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == aEstatus}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>estatusA">
									<liferay-ui:message key="CotizacionesPortlet.estatus" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>modoCotizacion" id="<portlet:namespace/>modoCotizacionA" class="mdb-select">
									<option value="0">
										<liferay-ui:message key="CotizacionesPortlet.titulo.all" />
									</option>
									<c:forEach items="${listaModo}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == aModoCotizacion}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>modoCotizacionA">
									<liferay-ui:message key="CotizacionesPortlet.modoCotizacion" />
								</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-lg-3">
							<!--div class="md-form form-group">
								<label for="modoCotizacion" class="active"> Creaci&oacute;n de la cotizaci&oacute;n Inicio </label>
								<div class="col">
									<input placeholder="Desde" type="text" id="fechaIAgente" value="${aFechaInicio }" name="<portlet:namespace/>fechaInicio" class="form-control datepicker">
								</div>
							</div-->
							
							<div id="date-fechaIAgente" class="md-form md-outline input-with-post-icon datepicker">
		                      <input id="fechaIAgente" placeholder="Desde" name="<portlet:namespace/>fechaInicio" type="text" class="form-control" value="${aFechaInicio }">
		                      <label for="fechaIAgente">Creaci&oacute;n de la cotizaci&oacute;n Inicio </label>
		                      <i class="fas fa-calendar input-prefix" tabindex=0></i>
		                    </div>
							
						</div>

						<div class="col-sm-6 col-lg-3">
							<!--div class="md-form form-group">
								<label for="modoCotizacion" class="active"> Creaci&oacute;n de la cotizaci&oacute;n Fin</label>
								<div class="col">
									<input placeholder="Hasta" type="text" id="fechaFAgente" value="${aFechaFin }" name="<portlet:namespace/>fechaFin" class="form-control datepicker">
								</div>
							</div-->
							
							<div id="date-fechaFAgente" class="md-form md-outline input-with-post-icon datepicker">
		                      <input id="fechaFAgente" placeholder="Hasta" name="<portlet:namespace/>fechaFin" type="text" class="form-control" value="${aFechaFin }">
		                      <label for="fechaFAgente"> Creaci&oacute;n de la cotizaci&oacute;n Fin</label>
		                      <i class="fas fa-calendar input-prefix" tabindex=0></i>
		                    </div>
							
						</div>


						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>agente" id="<portlet:namespace/>agenteA" class="mdb-select colorful-select dropdown-primary" searchable='<liferay-ui:message key="ModuloComisionesPortlet.buscar" />'>
									<c:if test="${fn:length(listaAgente) > 1}">
										<option value="0">
											<liferay-ui:message key="CotizacionesPortlet.titulo.all" />
										</option>
									</c:if>

									<c:forEach items="${listaAgente}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idPersona == aAgente}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idPersona}" ${estatusAnterior }>${opc.nombre}${opc.appPaterno}${opc.appMaterno}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>agenteA">
									<liferay-ui:message key="CotizacionesPortlet.agente" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<input type="text" id="AseguradoAgente" name="<portlet:namespace/>asegurado" value="${aAsegurado }" class="form-control">
								<input type="hidden" id="aAseguradoId" name="<portlet:namespace/>idPersona" value="${aAseguradoId }" class="form-control">
								<label for="AseguradoAgente">
									<liferay-ui:message key="CotizacionesPortlet.asegurado" />
								</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>tipoMovimiento" id="<portlet:namespace/>tipoMovimientoA" class="mdb-select">
									<option value="0">
										<liferay-ui:message key="CotizacionesPortlet.titulo.all" />
									</option>
									<c:forEach items="${listaTipoMovimiento}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == aTipoMovimiento}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>tipoMovimientoA">
									<liferay-ui:message key="CotizacionesPortlet.tipoMovimiento" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>moneda" id="<portlet:namespace/>monedaA" class="mdb-select">
									<option value="0">
										<liferay-ui:message key="CotizacionesPortlet.titulo.all" />
									</option>
									<c:forEach items="${listaMoneda}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == aMoneda}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>monedaA">
									<liferay-ui:message key="CotizacionesPortlet.moneda" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>producto" id="<portlet:namespace/>productoA" class="mdb-select">
									<option value="0">
										<liferay-ui:message key="CotizacionesPortlet.titulo.all" />
									</option>
									<c:forEach items="${listaProducto}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == aProducto}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>
								</select>
								<label for="<portlet:namespace/>productoA">
									<liferay-ui:message key="CotizacionesPortlet.producto" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>ramo" id="<portlet:namespace/>ramoA" class="mdb-select">
									<option value="0">
										<liferay-ui:message key="CotizacionesPortlet.titulo.all" />
									</option>
									<c:forEach items="${listaRamo}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == aRamo}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
									</c:forEach>
									<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
								</select>
								<label for="<portlet:namespace/>ramoA">
									<liferay-ui:message key="CotizacionesPortlet.ramo" />
								</label>
							</div>
						</div>
					</div>
					<c:if test="${ idPerfilUser ==  8 || idPerfilUser == 26}">
						<div class="row">
							<div class="col-sm-6 col-lg-3">
								<div class="md-form form-group">
									<select name="<portlet:namespace/>coaseguro" id="<portlet:namespace/>coaseguroA" class="mdb-select">
										<option value="0">Todos</option>
										<c:forEach items="${tipoCoaseguro}" var="opc">
											<c:set var="estatusAnterior" value="" />
											<c:if test="${opc.idCatalogoDetalle == tCoaseguro}">
												<c:set var="estatusAnterior" value="selected" />
											</c:if>
											<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
										</c:forEach>
									</select>
									<label for="<portlet:namespace/>coaseguroA">
										<liferay-ui:message key="CotizacionesPortlet.coaseguro" />
									</label>
								</div>
							</div>
							<div class="col-sm-6 col-lg-3">
								<div class="md-form form-group">
									<select name="<portlet:namespace/>canalNegocio" id="<portlet:namespace/>canalNegocioA" class="mdb-select">
										<option value="0">Todos</option>
										<c:forEach items="${canalNegocio}" var="opc">
											<c:set var="estatusAnterior" value="" />
											<c:if test="${opc.idCatalogoDetalle == canalNeg}">
												<c:set var="estatusAnterior" value="selected" />
											</c:if>
											<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
										</c:forEach>
									</select>
									<label for="<portlet:namespace/>canalNegocioA">
										<liferay-ui:message key="CotizacionesPortlet.canalNegocio" />
									</label>
								</div>
							</div>
							<div class="col-sm-6 col-lg-3">
								<div class="md-form form-group">
									<select name="<portlet:namespace/>endoso" id="<portlet:namespace/>endosoA" class="mdb-select">
										<option value="0">Todos</option>
										<c:forEach items="${tipoEndoso}" var="opc">
											<c:set var="estatusAnterior" value="" />
											<c:if test="${opc.idCatalogoDetalle == tEndoso}">
												<c:set var="estatusAnterior" value="selected" />
											</c:if>
											<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
										</c:forEach>
									</select>
									<label for="<portlet:namespace/>endosoA">
										<liferay-ui:message key="CotizacionesPortlet.endoso" />
									</label>
								</div>
							</div>
						</div>
					</c:if>
					<div class="row">
						<div class="col-md-12">
							<button class="btn btn-pink float-right">
								<liferay-ui:message key="CotizacionesPortlet.buscar" />
							</button>
						</div>
					</div>
				</form>
			</div>
			<div class="table-wrapper">
				<table class="table data-table table-striped table-bordered tablaAgente" style="width: 100%;">
					<thead>
						<tr>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.cotizadorTable" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.version" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.folio" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.fechaCreacion" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.modoCotizacion" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.estatus" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.producto" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.aseguradoTable" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.agenteTable" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.monedaTable" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.ramoTable" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.movimiento" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.poliza" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.endoso" />
							</th>
							<th>
								<liferay-ui:message key="CotizacionesPortlet.prima" />
							</th>
							<th>Usuario Cotiza</th>
							<th>Usuario Emite</th>
							<th class="all" data-orderable="false"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listaPendienteAgente}" var="pendiente">
							<tr>
								<td>${ pendiente.folio }</td>
								<td>${ pendiente.version }</td>
								<td>${ pendiente.folio }</td>
								<td class="fecha">${ pendiente.fechaCreacion }</td>
								<td>${ pendiente.modo }</td>
								<td>${ pendiente.estado }</td>
								<td>${ pendiente.producto }</td>
								<td>${ pendiente.asegurado }</td>
								<td>${ pendiente.agente }</td>
								<td>${ pendiente.moneda }</td>
								<td>${ pendiente.ramo }</td>
								<td>${ pendiente.tipoMovimiento }</td>
								<td>${ pendiente.poliza }</td>
								<td>${ pendiente.endoso }</td>
								<td>${ pendiente.prima }</td>
								<td>${ pendiente.usrCotiza }</td>
								<td>${ pendiente.usrEmite }</td>
								<td>
									<div class="actions-container dropleft">
										<button type="button" class="btn btn-outline-pink dropdown-menu-right px-3 py-2 waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<i class="fa fa-ellipsis-v" aria-hidden="true"></i>
										</button>
										<div class="dropdown-menu animated fadeIn">
											<!-- Validacion para las solicitudes web -->
											<!-- idProducto -> paquete familiar 1, empresarial 2 -->
											<c:if test="${ pendiente.modo == modoManual }">
												<c:set var="folio" value="${pendiente.folio}" scope="request" />
												<c:set var="rfc" value="${pendiente.rfc}" scope="request" />
												<c:set var="cotizacion" value="${pendiente.cotizacion}" scope="request" />
												<c:set var="endoso" value="${pendiente.endoso}" scope="request" />
												<c:set var="idCarpeta" value="${pendiente.idCarpeta}" scope="request" />
												<c:set var="estado" value="${pendiente.estado}" scope="request" />
												<c:set var="version" value="${pendiente.version}" scope="request" />
												<c:set var="solicitud" value="${pendiente.noSolicitud}" scope="request" />
												<c:set var="descProd" value="${pendiente.producto}" scope="request" />
												<c:set var="tipo" value="3" scope="request" />

												<jsp:include page="botones/btnConsultarSolicitud.jsp" />
											</c:if>
											<c:if test="${ pendiente.modo == modoWeb }">
												<c:set var="tipoCot" value="${ pendiente.idProducto == idProductoFamiliar ? 1 : 2 }" scope="request" />
												<c:set var="folio" value="${pendiente.folio}" scope="request" />
												<c:set var="cotizacion" value="${pendiente.cotizacion}" scope="request" />
												<c:set var="version" value="${pendiente.version}" scope="request" />
												<c:set var="rechazoCotizacion" value="${rechazoCotizacion}" scope="request" />
												<c:set var="poliza" value="${pendiente.poliza}" scope="request" />
												<c:set var="endoso" value="${pendiente.endoso}" scope="request" />
												<c:set var="idProducto" value="${ pendiente.idProducto }" scope="request" />

												<c:choose>
													<c:when test="${ fn:containsIgnoreCase(pendiente.tipoMovimiento, 'SEGURO NUEVO') }">
														<c:set var="isEndoso" value="${ false }" scope="request" />
														<!-- ESCENARIO1: LA COTIZACI&Oacute;N ES INICIADA POR EL PERFIL AGENTE / EJECUTIVO SIN PASAR POR EL PERFIL DE SUSCRIPTOR -->
														<c:if test="${ (pendiente.suscripcion == 0) && (pendiente.cotizosuscriptor == 0)}">
															<c:choose>
																<c:when test="${pendiente.idEstado == captura}">
																	<jsp:include page="botones/btnEditar.jsp" />
																	<jsp:include page="botones/btnCopiar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == revision}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacion}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacionRev}">
																	<jsp:include page="botones/btnConsultar.jsp" />

																</c:when>
																<c:when test="${pendiente.idEstado == cotizado}">
																	<jsp:include page="botones/btnCopiar.jsp" />
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == rechazada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == noAceptada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492}">
																	<jsp:include page="botones/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492bv}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == masDatos}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enEmision}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == emitido}">
																	<jsp:include page="botones/btnPoliza360.jsp" />
																</c:when>
															</c:choose>
														</c:if>

														<!-- ESCENARIO 3: LA COTIZACI&Oacute;N ES INICIADA POR EL PERFIL AGENTE / EJECUTIVO, EXCEDE SUS CAPACIDADES  Y ENVIA LA COTIZACI&Oacute;N AL PERFIL DE SUSCRIPTOR.
AMBOS PERFILES DEBEN PODER VER LA COTIZACI&Oacute;N EN SU LISTADO DE COTIZACIONES -->
														<c:if test="${ (pendiente.suscripcion == 1) && (pendiente.cotizosuscriptor == 0)}">
															<c:choose>
																<c:when test="${pendiente.idEstado == captura}">
																	<jsp:include page="botones/btnEditar.jsp" />
																	<jsp:include page="botones/btnCopiar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == revision}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacion}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacionRev}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == cotizado}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == rechazada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == noAceptada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492bv}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == masDatos}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enEmision}">
																	<!-- sin botones -->
																</c:when>
																<c:when test="${pendiente.idEstado == emitido}">
																	<jsp:include page="botones/btnPoliza360.jsp" />
																</c:when>
															</c:choose>
														</c:if>
													</c:when>
													<c:when test="${ fn:containsIgnoreCase(pendiente.tipoMovimiento, 'ENDOSO') }">
														<c:set var="isEndoso" value="${ true }" scope="request" />
														<c:set var="codEndoso" value="${ pendiente.codigoEndoso }" scope="request" />

														<!-- ESCENARIO1: LA COTIZACI&Oacute;N ES INICIADA POR EL PERFIL AGENTE / EJECUTIVO SIN PASAR POR EL PERFIL DE SUSCRIPTOR -->
														<c:if test="${ (pendiente.suscripcion == 0) && (pendiente.cotizosuscriptor == 0)}">
															<c:choose>
																<c:when test="${pendiente.idEstado == captura}">
																	<jsp:include page="botones/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == revision}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacion}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacionRev}">
																	<jsp:include page="botones/btnConsultar.jsp" />

																</c:when>
																<c:when test="${pendiente.idEstado == cotizado}">
																	<jsp:include page="botones/btnEditar.jsp" />

																	<jsp:include page="botones/btnRechazar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == rechazada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == noAceptada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492}">
																	<jsp:include page="botones/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492bv}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == masDatos}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enEmision}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == emitido}">
																	<jsp:include page="botones/btnPoliza360.jsp" />
																</c:when>
															</c:choose>
														</c:if>


														<!-- ESCENARIO 3: LA COTIZACI&Oacute;N ES INICIADA POR EL PERFIL AGENTE / EJECUTIVO, EXCEDE SUS CAPACIDADES  Y ENVIA LA COTIZACI&Oacute;N AL PERFIL DE SUSCRIPTOR.
AMBOS PERFILES DEBEN PODER VER LA COTIZACI&Oacute;N EN SU LISTADO DE COTIZACIONES -->
														<c:if test="${ (pendiente.suscripcion == 1) && (pendiente.cotizosuscriptor == 0)}">
															<c:choose>
																<c:when test="${pendiente.idEstado == captura}">
																	<jsp:include page="botones/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == revision}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacion}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacionRev}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == cotizado}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == rechazada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == noAceptada}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492bv}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == masDatos}">
																	<jsp:include page="botones/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enEmision}">
																	<!-- sin botones -->
																</c:when>
																<c:when test="${pendiente.idEstado == emitido}">
																	<jsp:include page="botones/btnPoliza360.jsp" />
																</c:when>
															</c:choose>
														</c:if>

													</c:when>
													<c:when test="${ fn:containsIgnoreCase(pendiente.tipoMovimiento, 'RENOVACION') }">
														<!-- ESCENARIO 1:  RENOVACI&Oacute;N AUTOM&Aacute;TICA -->
														<!--  La cotizaci&oacute;n de renovaci&oacute;n es solicitada por el perfil de agente ejecutivo el ESTADO de la P&oacute;liza es -->
														<c:if test="${ (pendiente.suscripcion == 0) && (pendiente.cotizosuscriptor == 0)}">
														<c:set var="polizaAnt" value="${pendiente.polizaAnterior}" scope="request" />
														
															<c:choose>
																<c:when test="${pendiente.idEstado == captura}">
																	<jsp:include page="botones/Renovacion/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == revision}">
																	<!-- Sin Botones -->
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacion}">
																	<jsp:include page="botones/Renovacion/btnEditar.jsp" />
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enCotizacionRev}">
																	<!-- Sin Botones -->
																</c:when>
																<c:when test="${pendiente.idEstado == cotizado}">
																	<jsp:include page="botones/Renovacion/btnEditar.jsp" />
																	<jsp:include page="botones/btnRechazar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == rechazada}">
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == noAceptada}">
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492}">
																	<jsp:include page="botones/Renovacion/btnEditar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == art492bv}">
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == masDatos}">
																	<jsp:include page="botones/Renovacion/btnEditar.jsp" />
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == enEmision}">
																	<jsp:include page="botones/Renovacion/btnConsultar.jsp" />
																</c:when>
																<c:when test="${pendiente.idEstado == emitido}">
																	<jsp:include page="botones/btnPoliza360.jsp" />
																</c:when>
															</c:choose>
														</c:if>
													</c:when>
												</c:choose>

											</c:if>

											<c:if test="${ permisoEmision }">

												<c:if test="${ pendiente.modo == modoManual && pendiente.idEstado == cotizado }">
													<a class="dropdown-item" onclick="submitTmx( '${solicitarTmx}',${pendiente.cotizacion},${pendiente.version} );">
														<i class="fas fa-print mr-2"></i>
														<span>
															<liferay-ui:message key="CotizacionesPortlet.solicita.emision" />
														</span>
													</a>
												</c:if>
											</c:if>


											<c:if test="${pendiente.idEstado == cotizado && pendiente.modo == modoManual }">
												<a class="dropdown-item" data-toggle="modal" href="#modal-revire" onclick="revireModal('${revire}','${ pendiente.cotizacion }','${ pendiente.version }')">
													<i class="fas fa-exchange-alt mr-2"></i>
													<span>
														<liferay-ui:message key="CotizacionesPortlet.revire" />
													</span>
												</a>
											</c:if>

											<a class="dropdown-item" data-toggle="modal" href="#modal-messages"
												onclick="verMensajes('<%= datosMensajes %>', '<%= saveComentarioURL %>','${ pendiente.folio }','${ pendiente.poliza }','${ pendiente.cotizacion }','${ pendiente.endoso }','${ pendiente.version }' )">
												<i class="far fa-comment mr-2"></i>
												<span>
													<liferay-ui:message key="CotizacionesPortlet.mensajes" />
												</span>
											</a>
											<a class="dropdown-item" data-toggle="modal" href="#modal-archives"
												onclick="verArchivos('<%= datosArchivos %>','${ pendiente.idCarpeta}', '${ pendiente.cotizacion }','${ pendiente.estado }')">
												<i class="far fa-file-alt mr-2"></i>
												<span>
													<liferay-ui:message key="CotizacionesPortlet.verArchivos" />
												</span>
											</a>

											<a class="dropdown-item" data-toggle="modal" href="#modal-help">
												<i class="fas fa-question mr-2"></i>
												<span>
													<liferay-ui:message key="CotizacionesPortlet.ayuda" />
												</span>
											</a>

										</div>
									</div>
								</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>
		</div>
	</div>
</section>




<!-- Modal cotizacion expirada -->
<div class="modal" id="modal-cotExpCot" tabindex="-1" role="dialog" aria-labelledby="cotExpCotLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="cotExpCotLabel">Cotizacio&oacute;n expirada</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body">

				<div class="row">
					<div class="col-12">
						<span id="cotExpCotTxt"></span>
					</div>
				</div>
			</div>

			<!--Footer-->
			<div class="modal-footer justify-content-center">
				<div class="row">
					<div class="col-md-6">
						<button class="btn btn-pink waves-effect waves-light" data-dismiss="modal" id="btncotExpiroSi">Entendido</button>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>

<!-- END Modal cotizacion expirada -->








<!-- Modal Ver mensajes -->
<div class="modal" id="modal-messages" tabindex="-1" role="dialog" aria-labelledby="messagesLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="messagesLabel">Mensajes</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="comments-wrapper">
					<div class="row px-lg-2 px-2">
						<div class="col-md-12 px-lg-auto px-0">
							<div class="chat-comments">
								<ul class="list-unstyled" id="listaComentarios">

								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="comment" id="agregarComentarioDivForm">
					<input type="hidden" id="urlAgregarComentario" value="" />
					<input type="hidden" id="cotizacionComentario" value="" />
					<input type="hidden" id="versionComentario" value="" />
					<input type="hidden" id="tipo" value="" />
					<div class="form-group basic-textarea">
						<textarea class="form-control pl-2 my-0" id="textoAgregarComentario" rows="3" maxlength="500" placeholder="Escribe tu comentario..."></textarea>
					</div>
					<button onclick="agregarComentarioSubmit()" class="btn btn-pink btn-rounded btn-sm waves-effect waves-light float-right">Agregar Comentario</button>
				</div>

			</div>
		</div>
	</div>
</div>
<!-- END Modal Ver mensajes -->

<!-- Modal Ver archivos -->
<div class="modal" id="modal-archives" tabindex="-1" role="dialog" aria-labelledby="archivesLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="archivesLabel">Archivos</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<input type="hidden" id="idCarpetaArchivo" value="">
			<div class="modal-body">

				<table id="tableArchivos" class="table simple-data-table table-striped table-bordered" style="width: 100%;">
					<thead>
						<tr>
							<th>Archivo</th>
							<th>Tipo</th>
							<th></th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>

				<form id="subirArchivoForm" action="<%=uploadFilesURL%>" method="post" enctype="multipart/form-data">
					<div>
						<input name="idCotizacion" type="hidden" id="idCotizacionArchivo" value="">
						<input id="input-b9" name="archivo[]" multiple type="file">
					</div>
				</form>
				<a class="btn btn-blue" id="subirArchivoModal" onclick="subirArchivoCot()"> Subir Archivo </a>



			</div>
		</div>
	</div>
</div>
<!-- END Modal Ver archivos -->


<!-- Modal Short Help -->
<div class="modal" id="modal-short-help" tabindex="-1" role="dialog" aria-labelledby="helpLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="helpLabel">Ayuda</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col">
							<div class="instruction">
								<h6 class="title font-weight-bold mb-3">
									<i class="far fa-comment pr-2"></i> Ver mensajes
								</h6>
								<p>Disponible en todos los estados de esta pantalla para lectura de mensajes. La funcionalidad para crear nuevos mensajes esta disponible en los estados: "EN CAPTURA", "COTIZADO", "SE
									NECESITAN M&Aacute;S ESTADOS"</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="instruction">
								<h6 class="title font-weight-bold mb-3">
									<i class="far fa-file-alt pr-2"></i> Ver archivos
								</h6>
								<p>Disponible en todos los estados de esta pantalla respetando las reglas de negocio siguientes: Los Agentes/Brokers s&oacute;lo pueden eliminar archivos cargados por otro perfil de agente o por
									s&iacute; mismos y que el estado de la cotizaci&oacute;n sea "CAPTURA" o "SE REQUIERE M&Aacute;S INFORMACI&oacute;N"</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- END Modal Short Help -->

<!-- Modal Revire -->
<div class="modal" id="modal-revire" tabindex="-1" role="dialog" aria-labelledby="revireLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="revireLabel">Revire: Pedir cambios a la cotizaci&oacute;n 985</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="">
					<input type="hidden" id="urlRevire" value="">
					<input type="hidden" id="urlRevireCotizacion" value="">
					<input type="hidden" id="urlRevireVersion" value="">
					<div class="md-form">
						<textarea type="text" id="comentarioRevireId" name="comments" placeholder="Descripci&oacute;n de los cambios a realizar en la cotizaci&oacute;n" aria-describedby="commentsHelp"
							class="form-control md-textarea" maxlength="500" rows="3"></textarea>
						<label for="comments">Comentarios</label>
						<small id="commentsHelp" class="text-muted"> Por favor indique los cambios a realizar en la propuesta de negocio </small>
					</div>
				</form>
				<button type="button" onclick="revireSubmit()" class="btn btn-pink btn-sm btn-rounded waves-effect waves-light float-right">Enviar</button>
			</div>
		</div>
	</div>
</div>
<!-- END Modal Revire -->
<!-- Modal Rechazo propuesta -->
<div class="modal" id="modal-rechazo" tabindex="-1" role="dialog" aria-labelledby="rechazoLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="rechazoLabel">Rechazar propuesta de negocio con folio 988</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<p class="section-description">Lamentamos que nuestra propuesta de negocio no haya cumplido con las expectativas del asegurado, agradecemos su retroalimentaci&oacute;n para mejorar.</p>
				<form action="">
					<div class="row">
						<div class="col-sm-12">
							<input type="hidden" id="urlRechazo" value="">
							<input type="hidden" id="urlRechazoCotizacion" value="">
							<input type="hidden" id="urlRechazoVersion" value="">


							<div class="md-form form-group">
								<select id="motivoSelect" name="motivoRechazo" class="mdb-select">
									<option value="" disabled selected>Seleccione una opci&oacute;n</option>
									<c:forEach items="${tipoRechazo}" var="opc">
										<option value="${opc.idCatalogoDetalle}">${opc.valor}</option>
									</c:forEach>

								</select>
								<label for="motivoRechazo">Motivo de rechazo</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="md-form">
								<textarea type="text" id="comentarioRechazoId" name="comments" placeholder="Agradecemos un comentario de retroalimentaci&oacute;n" maxlength="500" aria-describedby="commentsHelp"
									class="form-control md-textarea" rows="6"></textarea>
								<label for="comments">Comentarios</label>
							</div>
						</div>
					</div>
				</form>
				<button type="button" onclick="rechazoSubmit()" class="btn btn-pink btn-rounded btn-sm waves-effect waves-light float-right">Enviar</button>
			</div>
		</div>
	</div>
</div>
<!-- END Modal Rechazo propuesta -->

<!-- Modal Help -->
<div class="modal" id="modal-help" tabindex="-1" role="dialog" aria-labelledby="helpLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="helpLabel">Ayuda</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col">
							<div class="instruction">
								<h6 class="title font-weight-bold mb-3">
									<i class="fas fa-print pr-2"></i> Solicitar emisi&oacute;n
								</h6>
								<p>Disponible en los estados "COTIZADO" y "SE NECESITAN M&Aacute;S DATOS".</p>
								<ul class="list-group list-group-flush">
									<li class="list-group-item">COTIZADO: El agente utiliza este bot&oacute;n para solicitar a TMX que emita la p&oacute;liza. Para las cotizaciones Web o Autom&aacute;ticas, la vigencia de la p&oacute;liza comenzar&aacute; a
										partir de la fecha de solicitud de emisi&oacute;n, es decir a partir de que el agente presione este bot&oacute;n.</li>
									<li class="list-group-item">SE NECESITAN M&Aacute;S DATOS: El agente utiliza esta funci&oacute;n en este estado para regresar la cotizaci&oacute;n a TMX. El estado SE NECESITAN M&Aacute;S DATOS indica que TMX
										requiere m&aacute;s informaci&oacute;n o m&aacute;s documentos para poder continuar con el proceso de art&iacute;culo 492.</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="instruction">
								<h6 class="title font-weight-bold mb-3">
									<i class="fas fa-exchange-alt pr-2"></i> Revire
								</h6>
								<p>Disponible solo para cotizaciones con estado "COTIZADO" y con modo de cotizaci&oacute;n "MANUAL". El agente utiliza este bot&oacute;n para solicitar a TMX que haga cambios en la cotizaci&oacute;n.</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="instruction">
								<h6 class="title font-weight-bold mb-3">
									<i class="far fa-edit pr-2"></i> Editar la cotizaci&oacute;n
								</h6>
								<p>Disponible solo para cotizaciones con estado "COTIZADO" y con modo de cotizaci&oacute;n "WEB". El agente utiliza este bot&oacute;n para modificar informaci&oacute;n en la cotizaci&oacute;n</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="instruction">
								<h6 class="title font-weight-bold mb-3">
									<i class="far fa-clone pr-2"></i> Copiar la cotizaci&oacute;n
								</h6>
								<p>Disponible solo para cotizaciones con estado "EN CAPTURA", "COTIZADO" y "NO ACEPTADO" y adem&aacute;s con modo de cotizaci&oacute;n "WEB". El agente utiliza este bot&oacute;n para crear una copia de la
									cotizaci&oacute;n. El sistema genera un nuevo ID de cotizaci&oacute;n comn estado "EN CAPTURA" al utilizar esta funci&oacute;n. (No copia documentes ni mensajes).</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="instruction">
								<h6 class="title font-weight-bold mb-3">
									<i class="far fa-trash-alt pr-2"></i> Rechazar propuesta de negocio
								</h6>
								<p>Disponible solo en estado "COTIZADO". El agente utiliza este bot&oacute;n para indicar que este negocio fue ganado por otra compa&ntilde;&iacute;a de seguros y por lo tanto no es necesario que TMX emita la
									p&oacute;liza.</p>
								<ul class="list-group list-group-flush">
									<li class="list-group-item">Para las cotizaciones de modo "MANUAL" el sistema rechaza el folio o cotizaci&oacute;n</li>
									<li class="list-group-item">Para las cotizaciones de modo "WEB" o "AUTOM&Aacute;TICA" el sistema &uacute;nicamente rechaza la versi&oacute;n seleccionada.</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="instruction">
								<h6 class="title font-weight-bold mb-3">
									<i class="far fa-comment pr-2"></i> Ver mensajes
								</h6>
								<p>Disponible en todos los estados de esta pantalla para lectura de mensajes. La funcionalidad para crear nuevos mensajes esta disponible en los estados: "EN CAPTURA", "COTIZADO", "SE
									NECESITAN M&Aacute;S ESTADOS"</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="instruction">
								<h6 class="title font-weight-bold mb-3">
									<i class="far fa-file-alt pr-2"></i> Ver archivos
								</h6>
								<p>Disponible en todos los estados de esta pantalla respetando las reglas de negocio siguientes: Los Agentes/Brokers s&oacute;lo pueden eliminar archivos cargados por otro perfil de agente o por
									s&iacute; mismos y que el estado de la cotizaci&oacute;n sea "CAPTURA" o "SE REQUIERE M&Aacute;S INFORMACI&Oacute;N"</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- END Modal Help -->
<!-- BEGIN Modal Reproceso -->
<div class="modal" id="modal-reproceso" tabindex="-1" role="dialog" aria-labelledby="reprocesoLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reprocesoLabel">Reproceso</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="">
					<input type="hidden" id="urlReproceso" value="">
					<input type="hidden" id="urlReprocesoCotizacion" value="">
					<input type="hidden" id="urlReprocesoVersion" value="">
					<div class="md-form">
						<textarea type="text" id="comentarioReprocesoId" name="commentsReproceso" placeholder="Motivo de Reproceso" aria-describedby="commentsHelpReproceso"
							class="form-control md-textarea" maxlength="500" rows="3"></textarea>
						<label for="commentsReproceso">Comentarios</label>
						<small id="commentsHelpReproceso" class="text-muted">Motivo de Reproceso</small>
					</div>
				</form>
				<button type="button" onclick="reprocesoSubmit()" class="btn btn-pink btn-sm btn-rounded waves-effect waves-light float-right">Aceptar</button>
			</div>
		</div>
	</div>
</div>
<!-- END Modal Reproceso -->

<a id='dwnldLnk' style="display: none;" />

<script src="<%=request.getContextPath()%>/js/jquery-ui.min.js?v=${versionEntrega}"></script>
<script src="<%=request.getContextPath()%>/js/customPaginate.js?v=${versionEntrega}"></script>
<script src="<%=request.getContextPath()%>/js/fileinput.min.js?v=${versionEntrega}"></script>
<script src="<%=request.getContextPath()%>/js/fileinput-es.js?v=${versionEntrega}"></script>
<script src="<%=request.getContextPath()%>/js/suscripcion.js?v=${versionEntrega}"></script>
<script src="<%=request.getContextPath()%>/js/custom.js?v=${versionEntrega}"></script>

<script>


var redirigeURL = '${redirigeURL}';
var redirige360URL = '${redirige360URL}';
var redirigeSolicitudURL = '${redirigeSolicitudURL}';
var searchPersonURL = '${searchPersonURL}';
</script>