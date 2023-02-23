<%@ include file="./init.jsp" %>

<portlet:resourceURL id="/cotizacion/retroactividad" var="retroactividad"/>


<c:if test="${idPerfilUser < 4 || idPerfilUser == 8 || idPerfilUser == 26}" > <!-- lt -- menor que -->
	<%--<%@ include file="./viewAgentes.jsp" %>--%>
	<jsp:include page="viewAgentes.jsp"/>
</c:if>
<c:if test="${((idPerfilUser > 3) && (idPerfilUser < 7)) || idPerfilUser == 50}">	<!-- gt -- mayor que -->
	<jsp:include page="viewSuscriptor.jsp"/>
</c:if>
<c:if test="${ idPerfilUser == 25}">	<!-- gt -- mayor que -->
	<jsp:include page="viewJapones.jsp"/>
</c:if>

<c:set var="versionFecha" scope="session" value="V.1.28092020.1400" />


<input id="txtRetroactividad" type="hidden" name="txtRetroactividad" class="form-control" value="${ retroactividad }">