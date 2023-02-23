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

<portlet:resourceURL id="/list/cotizacion/redirigeVoboReaseguro" var="redirigeReaseguroURL"/>

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
<c:set var="voboRea" value="362" property="Vo.Bo. REASEGURO" />
<c:set var="idProductoEmpresarial" value="209" />
<c:set var="idProductoFamiliar" value="208" />
<c:set var="idProductoManual" value="783" />
<c:set var="modoManual" value="MANUAL" />
<c:set var="modoWeb" value="WEB" />

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
				<liferay-ui:message key="CotizacionesPortlet.titulo.consultaSuscriptor" />
				<!-- 				V 1.1 -->
			</h1>
			<div class="section-nav-wrapper"></div>
			<div class="form-wrapper">
				<form id="search-form" class="mb-4" action="<%=pendientesAgente%>" method="POST">
					<div class="row">
						<div class="col-sm-6 col-lg-3">
							<div class="row">
								<div class="col">
									<div class="md-form form-group">
										<input id="folioTMX" type="text" name="<portlet:namespace/>folioTMX" value="" class="form-control">
										<label for="folioTMX">
											<liferay-ui:message key="CotizacionesPortlet.folioTmx" />
										</label>
									</div>
								</div>
								<div class="col">
									<div class="md-form form-group">
										<input id="idCotizador" type="text" name="<portlet:namespace/>idCotizador" value="" class="form-control">
										<label for="idCotizador">
											<liferay-ui:message key="CotizacionesPortlet.cotizador" />
										</label>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<input id="poliza" type="text" name="<portlet:namespace/>poliza" value="" class="form-control">
								<label for="poliza">
									<liferay-ui:message key="CotizacionesPortlet.poliza" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>estatus" class="mdb-select">
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
								<label for="estatus">
									<liferay-ui:message key="CotizacionesPortlet.estatus" />
								</label>
							</div>
						</div>
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>modoCotizacion" class="mdb-select">
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
								<label for="modoCotizacion">
									<liferay-ui:message key="CotizacionesPortlet.modoCotizacion" />
								</label>
							</div>
						</div>
					</div>
					<!-- ROW -->

					<div class="row">
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<label for="modoCotizacion" class="active"> Creaci&oacute;n de la cotizaci&oacute;n Inicio </label>
								<div class="col">
									<input placeholder="Desde" type="text" id="fechaIAgente" value="${aFechaInicio }" name="<portlet:namespace/>fechaInicio" class="form-control datepicker">
								</div>
							</div>
						</div>

						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<label for="modoCotizacion" class="active"> Creaci&oacute;n de la cotizaci&oacute;n Fin</label>
								<div class="col">
									<input placeholder="Hasta" type="text" id="fechaFAgente" value="${aFechaFin }" name="<portlet:namespace/>fechaFin" class="form-control datepicker">
								</div>
							</div>
						</div>

						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>agenteS" class="mdb-select colorful-select dropdown-primary" searchable='<liferay-ui:message key="ModuloComisionesPortlet.buscar" />'>
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
								<label for="agenteS">
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

					<!-- ROW -->

					<div class="row">
						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>tipoMovimiento" class="mdb-select">
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
								<label for="tipoMovimiento">
									<liferay-ui:message key="CotizacionesPortlet.tipoMovimiento" />
								</label>
							</div>
						</div>

						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>moneda" class="mdb-select">
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
								<label for="moneda">
									<liferay-ui:message key="CotizacionesPortlet.moneda" />
								</label>
							</div>
						</div>

						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>producto" class="mdb-select">
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
								<label for="producto">
									<liferay-ui:message key="CotizacionesPortlet.producto" />
								</label>
							</div>
						</div>

						<div class="col-sm-6 col-lg-3">
							<div class="md-form form-group">
								<select name="<portlet:namespace/>ramo" class="mdb-select">
									<option value="0">
										<liferay-ui:message key="CotizacionesPortlet.titulo.all" />
									</option>
									<c:forEach items="${listaRamo}" var="opc">
										<c:set var="estatusAnterior" value="" />
										<c:if test="${opc.idCatalogoDetalle == aRamo}">
											<c:set var="estatusAnterior" value="selected" />
										</c:if>
										<option value="${opc.idCatalogoDetalle}" ${estatusAnterior }>${opc.valor}</option>
									</c:forEach>
								</select>
								<label for="ramo">
									<liferay-ui:message key="CotizacionesPortlet.ramo" />
								</label>
							</div>
						</div>

					</div>
					<!-- /ROW -->
					<!-- ROW -->
					<!--<div class="row">
						<div class="col-md-12">
							<button class="btn btn-pink float-right">
								<liferay-ui:message key="CotizacionesPortlet.buscar" />
							</button>
						</div>
					</div>-->
					<br/>
					<div class="row">
						<div class="col-md-12">
							<div class="col-md-3 float-right">
								<button class="btn btn-pink float-right">
									<liferay-ui:message key="CotizacionesPortlet.buscar" />
								</button>
							</div>
						</div>
					</div>
					<br/>
					<!-- /ROW -->

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

								<!-- ---------------- -->
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
														
														<c:if test="${ (pendiente.idTipoEndoso == 0) }">
															<c:set var="isEndoso" value="${ false }" scope="request" />

															<!-- ESCENARIO 2 : LA COTIZACIÓN ES INICIADA POR EL PERFILSUSCRIPTOR SIN PASAR POR EL PERFIL DE AAGENTE EJECUTIVO -->
															<c:if test="${ (pendiente.suscripcion == 1) && (pendiente.cotizosuscriptor == 1)}">
																<c:choose>
																	<c:when test="${pendiente.idEstado == captura}">
																		<jsp:include page="botones/btnEditar.jsp" />
																		<jsp:include page="botones/btnCopiar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == revision}">
																		<jsp:include page="botones/btnEditar.jsp" />
																		<jsp:include page="botones/btnCopiar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == enCotizacion}">
																		<jsp:include page="botones/btnEditar.jsp" />
																		<jsp:include page="botones/btnCopiar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == enCotizacionRev}">
																		<jsp:include page="botones/btnEditar.jsp" />
																		<jsp:include page="botones/btnCopiar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == cotizado}">
																		<jsp:include page="botones/btnEditar.jsp" />
																		<jsp:include page="botones/btnCopiar.jsp" />
																		<jsp:include page="botones/btnRechazar.jsp" />
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
																		<jsp:include page="botones/btnConsultar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == emitido}">
																		<jsp:include page="botones/btnPoliza360.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == voboRea}">
																		<jsp:include page="botones/btnVoboReaseguro.jsp" />
																	</c:when>
																</c:choose>
															</c:if>

															<!-- ESCENARIO 3: LA COTIZACIÓN ES INICIADA POR EL PERFIL AGENTE / EJECUTIVO, EXCEDE SUS CAPACIDADES  Y ENVIA LA COTIZACIÓN AL PERFIL DE SUSCRIPTOR.
AMBOS PERFILES DEBEN PODER VER LA COTIZACIÓN EN SU LISTADO DE COTIZACIONES -->
															<c:if test="${ (pendiente.suscripcion == 1) && (pendiente.cotizosuscriptor == 0)}">
																<c:choose>
																	<c:when test="${pendiente.idEstado == captura}">
																		<!-- sin botones -->
																	</c:when>
																	<c:when test="${pendiente.idEstado == revision}">
																		<jsp:include page="botones/btnConsultarRevision.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == enCotizacion}">
																		<jsp:include page="botones/btnEditar.jsp" />
																		<jsp:include page="botones/btnCopiar.jsp" />
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
																		<jsp:include page="botones/btnEmite.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == emitido}">
																		<jsp:include page="botones/btnPoliza360.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == voboRea}">
																		<jsp:include page="botones/btnVoboReaseguro.jsp" />
																	</c:when>
																</c:choose>
															</c:if>
														</c:if>



														<c:if test="${ (pendiente.idTipoEndoso > 0) }">
															<c:set var="isEndoso" value="${ true }" scope="request" />
															<c:set var="codEndoso" value="${ pendiente.codigoEndoso }" scope="request" />


															<!-- ESCENARIO 2 : LA COTIZACIÓN ES INICIADA POR EL PERFILSUSCRIPTOR SIN PASAR POR EL PERFIL DE AAGENTE EJECUTIVO -->
															<c:if test="${ (pendiente.suscripcion == 1) && (pendiente.cotizosuscriptor == 1)}">
																<c:choose>
																	<c:when test="${pendiente.idEstado == captura}">
																		<jsp:include page="botones/btnEditar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == revision}">
																		<jsp:include page="botones/btnEditar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == enCotizacion}">
																		<jsp:include page="botones/btnEditar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == enCotizacionRev}">
																		<jsp:include page="botones/btnEditar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == cotizado}">
																		<jsp:include page="botones/btnEditar.jsp" />
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
																		<jsp:include page="botones/btnConsultar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == emitido}">
																		<jsp:include page="botones/btnPoliza360.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == voboRea}">
																		<jsp:include page="botones/btnVoboReaseguro.jsp" />
																	</c:when>
																</c:choose>
															</c:if>

															<!-- ESCENARIO 3: LA COTIZACIÓN ES INICIADA POR EL PERFIL AGENTE / EJECUTIVO, EXCEDE SUS CAPACIDADES  Y ENVIA LA COTIZACIÓN AL PERFIL DE SUSCRIPTOR.
AMBOS PERFILES DEBEN PODER VER LA COTIZACIÓN EN SU LISTADO DE COTIZACIONES -->
															<c:if test="${ (pendiente.suscripcion == 1) && (pendiente.cotizosuscriptor == 0)}">
																<c:choose>
																	<c:when test="${pendiente.idEstado == captura}">
																		<!-- sin botones -->
																	</c:when>
																	<c:when test="${pendiente.idEstado == revision}">
																		<jsp:include page="botones/btnConsultarRevision.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == enCotizacion}">
																		<jsp:include page="botones/btnEditar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == enCotizacionRev}">
																		<jsp:include page="botones/btnEditar.jsp" />
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
																		<jsp:include page="botones/btnEditar.jsp" />
																		<jsp:include page="botones/btnConsultar.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == enEmision}">
																		<jsp:include page="botones/btnEditar.jsp" />
																		<jsp:include page="botones/btnEmite.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == emitido}">
																		<jsp:include page="botones/btnPoliza360.jsp" />
																	</c:when>
																	<c:when test="${pendiente.idEstado == voboRea}">
																		<jsp:include page="botones/btnVoboReaseguro.jsp" />
																	</c:when>
																</c:choose>
															</c:if>
														</c:if>
													</c:if>

													<a class="dropdown-item" data-toggle="modal" href="#modal-messages"
														onclick="verMensajes('<%= datosMensajes %>', '<%= saveComentarioURL %>','${ pendiente.folio }','${ pendiente.poliza }','${ pendiente.cotizacion }','${ pendiente.endoso }','${ pendiente.version }', ${tipo})">
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
								<!-- ---------------- -->
							</tbody>
						</table>
					</div>

				</form>
			</div>
		</div>


		<!--------------- MODALES --------------->


		<!-- Modal cotizacion expirada -->
		<div class="modal" id="modal-cotExpCot" tabindex="-1" role="dialog" aria-labelledby="cotExpCotLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="cotExpCotLabel">Cotizaci&oacute;n expirada</h5>
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
							<input type="hidden" id="urlAgregarComentario" value="">
							<input type="hidden" id="cotizacionComentario" value="">
							<input type="hidden" id="versionComentario" value="">
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
											<li class="list-group-item">COTIZADO: El agente utiliza este bot&oacute;n para solicitar a TMX que emita la p&oacute;liza. Para las cotizaciones Web o Autom&aacute;ticas, la vigencia de la p&oacute;liza comenzar&aacute;
												a partir de la fecha de solicitud de emisi&oacute;n, es decir a partir de que el agente presione este bot&oacute;n.</li>
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
										<p>Disponible solo en estado "COTIZADO". El agente utiliza este bot&oacute;n para indicar que este negocio fue ganado por otra compa&ntilde;&iacute;a de seguros y por lo tanto no es necesario que TMX emita
											la p&oacute;liza.</p>
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
										<p>Disponible en todos los estados de esta pantalla respetando las reglas de negocio siguientes: Los Agentes/Brokers s&oacute;lo pueden eliminar archivos cargados por otro perfil de agente o
											por s&iacute; mismos y que el estado de la cotizaci&oacute;n sea "CAPTURA" o "SE REQUIERE M&Aacute;S INFORMACI&oacute;N"</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- END Modal Help -->

		<!--------------- /MODALES --------------->

	</div>
</section>

<script src="<%=request.getContextPath()%>/js/jquery-ui.min.js?v=${versionEntrega}"></script>
<script src="<%=request.getContextPath()%>/js/customPaginate.js?v=${versionEntrega}"></script>
<script src="<%=request.getContextPath()%>/js/fileinput.min.js?v=${versionEntrega}"></script>
<script src="<%=request.getContextPath()%>/js/fileinput-es.js?v=${versionEntrega}"></script>
<script src="<%=request.getContextPath()%>/js/suscripcion.js?v=${versionEntrega}"></script>

<script type="text/javascript">
	$( document ).ready( function() {
		var myDate = new Date();

		finInputA = $( '#fechaFAgente' ).pickadate( {
			format : 'dd/mm/yyyy',
			formatSubmit : 'dd/mm/yyyy'
		} );

		finPickerA = finInputA.pickadate( 'picker' );

		finInputT = $( '#fechaFTokio' ).pickadate( {
			format : 'dd/mm/yyyy',
			formatSubmit : 'dd/mm/yyyy'
		} );

		finPickerT = finInputT.pickadate( 'picker' );

		inicioInputA = $( '#fechaIAgente' ).pickadate( {
			format : 'dd/mm/yyyy',
			formatSubmit : 'dd/mm/yyyy'
		} );

		inicioPickerA = inicioInputA.pickadate( 'picker' );

		inicioInputT = $( '#fechaITokio' ).pickadate( {
			format : 'dd/mm/yyyy',
			formatSubmit : 'dd/mm/yyyy'
		} );

		inicioPickerT = inicioInputT.pickadate( 'picker' );

		$( ".fecha" ).each( function() {
			value = $( this ).text();
			value = new Date( parseInt( value.replace( "/Date(", "" ).replace( ")/", "" ), 10 ) );
			month = value.getMonth() + 1;
			console.log( month );
			if (month <= 9) {
				month = "0" + month;
			}
			$( this ).text( value.getDate() + "/" + month + "/" + value.getFullYear() )
		} );
	} );

	function verArchivos(url, idCarpeta, cotizacion, estado) {
		console.log( "obtiene docs" );

		$( "#subirArchivoForm" ).hide();
		$( "#subirArchivoModal" ).hide();
		$( "#tableArchivos tbody" ).html( "" );
		$( "#idCarpetaArchivo" ).val( idCarpeta );
		$( "#idCotizacionArchivo" ).val( cotizacion );
		console.log( estado );
		if (estado == "SE NECESITAN MÁS DATOS" || estado == "EN CAPTURA") {
			console.log( "muestra" );
			$( "#subirArchivoForm" ).show();
			$( "#subirArchivoModal" ).show();
		} else {
			console.log( "oculta" );
			$( "#subirArchivoForm" ).hide();
			$( "#subirArchivoModal" ).hide();
		}

		console.log( "----" );
		console.log( "idCarpeta" + idCarpeta );
		console.log( "----" );

		showLoader();
		$.ajax(
				{
					url : url,
					type : 'POST',
					data : {
						cotizacion : idCarpeta
					},
					success : function(data) {
						var archivo = JSON.parse( data );
						console.log( "respuesta archivo:" + data );
						$.each( archivo.listaDocumento, function(i, stringJson) {

							var htmlTabla;
							htmlTabla = "<tr>"

							+ "<td>" + stringJson.nombre + stringJson.extension + "</td>" + "<td>" + stringJson.tipo
									+ "</td>"
									+ "<td> <button class=\"btn btn-primary \" onclick=\" descargarDocumento( "
									+ stringJson.idCarpeta + "," + stringJson.idDocumento + ","
									+ stringJson.idCatalogoDetalle + ") \"> Descargar </button> </td>" + "</tr>";

							$( '#tableArchivos tbody' ).append( htmlTabla );

						} );
						$("#modal-archives").modal("show");

					}
				} ).always( function() {
			hideLoader();
		} );
	}

	function descargarDocumento(idCarpeta, idDocumento, idCatalogoDetalle) {
		/* llamar a descargar documento */

		console.log( "obtiene docs" );
		showLoader();
		$.ajax( {
			url : '${descargarDocumento}',
			type : 'POST',
			data : {
				idCarpeta : idCarpeta,
				idDocumento : idDocumento,
				idCatalogoDetalle : idCatalogoDetalle
			},
			success : function(data) {

				var archivo = JSON.parse( data );

				if (archivo.code == 0) {
/*
					fileAux = 'data:application/octet-stream;base64,' + archivo.documento
					var dlnk = document.getElementById( 'dwnldLnk' );
					dlnk.href = fileAux;
					dlnk.download = archivo.nombre + '.' + archivo.extension;
					dlnk.click();
*/

					if(detectIEEdge()){
						fileAux = 'data:application/octet-stream;base64,'+archivo.documento
						var dlnk = document.getElementById('dwnldLnk');
						dlnk.href = fileAux;
						dlnk.download = archivo.nombre+'.'+archivo.extension;
						location.href=document.getElementById("dwnldLnk").href;
						/*dlnk.click();*/
					}else{
						/*
						 * downloadDocument('archivo base 64' , 'nombre.extension' );
						 */
						downloadDocument(archivo.documento, archivo.nombre+'.'+archivo.extension);
					}
					hideLoader();

				} else {
					showMessageError( ".navbar", archivo.msg, 0 );
				}

			}
		} ).always( function() {
			hideLoader();
		} );

	}

	function urltoFile(url, filename, mimeType) {
		return (fetch( url ).then( function(res) {
			return res.arrayBuffer();
		} ).then( function(buf) {
			return new File( [ buf ], filename, {
				type : mimeType
			} );
		} ));
	}

	function agregaTiempo(comentario){
		const str = comentario.fecha;
		const [dateComponents, timeComponents] = str.split(' ');
		const [day, month, year] = dateComponents.split('/');
		const [hours, minutes] = timeComponents.split(':');
		const date = new Date(+year, month - 1, +day, +hours, +minutes, 0);
		comentario.tiempo=date.getTime();
		return comentario;
	}

	function verMensajes(url, url2, folio, poliza, cotizacion, endoso, version, tipo) {
		console.log( "obtiene mensajes" );
		$( "#listaComentarios" ).html( "" );
		$( "#textoAgregarComentario" ).val( "" );

		showLoader();
		agregarComentarioModal( url2, cotizacion, version, tipo);
		$.ajax({
			url : url,
			type : 'POST',
			data : {
					folio : folio,
					poliza : poliza,
					cotizacion : cotizacion,
					endoso : endoso,
					version : version
				},
			success : function(data) {
				var response = JSON.parse(data);
				if(response.code === 0){
					let comentariosSpace = $("#listaComentarios")
					comentariosSpace.html("");
					let arrayComentarios = response.listaComentario;
					$(arrayComentarios).each(function (key,data) {
						data=agregaTiempo(data);
					});
					arrayComentarios = arrayComentarios.sort((a,b)=>a.tiempo-b.tiempo);
					let comentarioHtml;
					let nom;
					let iniciales;
					for(let comentario of arrayComentarios){
						console.log(comentario);
						nom = comentario.usuario;
						iniciales = nom.substring(0, 1).toUpperCase();
						comentarioHtml = "<li class='justify-content-between mb-3'>"
								+"<div class='comment-body white p-3 z-depth-1'>"
								+"<div class='header'>"
								+"<div class='row'>"
								+"<div class='col-md-2 col-sm-2 text-right'>"
								+"<small class='text-muted'><i class='fa fa-clock-o'></i>" + comentario.fecha + "</small>"
								+"</div>"
								+"</div>"
								+"<div class='row'>"
								+"<div class='col-md-12 col-sm-12 text-center'>"
								+"<div class='user-acronym btn-floating btn-sm light-blue darken-4 waves-effect waves-light' style='padding: 1%;'>"
								+"<span style='color: #fff'>" + iniciales + "</span>"
								+"</div>"
								+"<strong class='primary-font'>" + comentario.usuario + "</strong>"
								+"</div>"
								+"</div>"
								+"</div>"
								+"<hr class='w-100'>"
								+"<h6 class='font-weight-bold mb-2'><strong></strong></h6>"
								+"<p class='mb-0 text-center'>" + comentario.comentario + "</p>"
								+"</div>"
								+"</li>";
						comentariosSpace.append(comentarioHtml);
					}
					$("#modal-messages").modal("show");
				}else{
					showMessageError('.navbar', response.msg, 0);
				}
			}
		} ).always( function() {
			hideLoader();
		} );
	}

	function revireModal(url, cotizacion, version) {
		$( "#urlRevire" ).val( url );
		$( "#urlRevireCotizacion" ).val( cotizacion );
		$( "#urlRevireVersion" ).val( version );

		$( "#comentarioRevireId" ).val( "" );
		$("#modal-revire").modal("show");
	}

	function rechazoModal(url, folio, cotizacion, version) {
		$( "#urlRechazo" ).val( url );
		$( "#urlRechazoCotizacion" ).val( cotizacion );
		$( "#urlRechazoVersion" ).val( version );

		$( "#comentarioRechazoId" ).val( "" );
		$( "#rechazoLabel" ).text( "Rechazar propuesta de negocio con folio " + folio );

	}

	function agregarComentarioModal(url, cotizacion, version, tipo) {
		$( "#urlAgregarComentario" ).val( url );
		$( "#cotizacionComentario" ).val( cotizacion );
		$( "#versionComentario" ).val( version );
		$("#tipo").val(tipo);
	}

	function revireSubmit() {
		url = $( "#urlRevire" ).val();
		cotizacion = $( "#urlRevireCotizacion" ).val();
		version = $( "#urlRevireVersion" ).val();

		showLoader();
		$.ajax( {
			url : url,
			type : 'POST',
			data : {
				comentario : $( "#comentarioRevireId" ).val(),
				cotizacion : $( "#urlRevireCotizacion" ).val(),
				version : $( "#urlRevireVersion" ).val()
			},
			success : function(data) {
				console.log( data )
				var respuesta = JSON.parse( data );
				console.log( respuesta );
				console.log( respuesta );
				if (respuesta.code == 0) {
					showMessageSuccess( ".navbar", respuesta.msg, 0 );
				} else {
					showMessageError( ".navbar", respuesta.msg, 0 );
				}
				$( "#modal-revire" ).modal( "hide" );
				setTimeout( recargaPagina, 5000 );

			}
		} ).always( function() {
			hideLoader();
		} );

	}

	function agregarComentarioSubmit() {
		url = $( "#urlAgregarComentario" ).val();

		showLoader();
		$.ajax( {
			url : url,
			type : 'POST',
			data : {
				comentario : $( "#textoAgregarComentario" ).val(),
				cotizacion : $( "#cotizacionComentario" ).val(),
				version : $( "#versionComentario" ).val(),
				tipo:$("#tipo").val()
			},
			success : function(data) {
				console.log( data )
				var respuesta = JSON.parse( data );
				console.log( respuesta );
				if (respuesta.code == 0) {
					showMessageSuccess( ".navbar", respuesta.msg, 0 );
				} else {
					showMessageError( ".navbar", respuesta.msg, 0 );
				}

			}
		} ).always( function() {
			$( "#textoAgregarComentario" ).val( "" );
			hideLoader();
			$( "#modal-messages" ).modal( 'toggle' );
		} );

	}

	function rechazoSubmit() {
		url = $( "#urlRechazo" ).val();
		/*	$("#urlRechazoCotizacion").val(cotizacion);
		 $("#urlRechazoVersion").val(version);*/
		showLoader();
		$.ajax( {
			url : url,
			type : 'POST',
			data : {
				motivoRechazo : $( "#motivoRechazo" ).val(),
				motivo : $( "#comentarioRechazoId" ).val(),
				cotizacion : $( "#urlRechazoCotizacion" ).val(),
				version : $( "#urlRechazoVersion" ).val()
			},
			success : function(data) {
				var respuesta = JSON.parse( data );
				console.log( respuesta );
				if (respuesta.code == 0) {

					showMessageSuccess( ".navbar", respuesta.msg, 0 );
				} else {
					showMessageError( ".navbar", respuesta.msg, 0 );
				}
				setTimeout( recargaPagina, 5000 );
			}
		} ).always( function() {
			$( "#modal-rechazo" ).modal( 'toggle' );
			hideLoader();
		} );
	}

	function submitTmx(url, cotizacion, version) {

		showLoader();
		$.ajax( {
			url : url,
			type : 'POST',
			data : {
				tmx : 1,
				cotizacion : cotizacion,
				version : version
			},
			success : function(data) {
				var respuesta = JSON.parse( data );
				console.log( respuesta );
				if (respuesta.code == 0) {
					showMessageSuccess( ".navbar", respuesta.msg, 0 );
					hideLoader();
					setTimeout( recargaPagina, 5000 );
				} else {
					showMessageError( ".navbar", respuesta.msg, 0 );
				}

			}
		} ).always( function() {
			hideLoader();
		} );;
	}

	function recargaPagina() {
		window.location.reload();
	}
	
	
	var redirigeURL = '${redirigeURL}';
	var redirige360URL = '${redirige360URL}';
	
	var redirigeReaseguroURL = '${redirigeReaseguroURL}';
	var redirigeSolicitudURL = '${redirigeSolicitudURL}';
</script>