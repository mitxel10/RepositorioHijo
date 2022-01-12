<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsps/templates/taglibs.jsp"%>
prueba hijo
<%-- DETALLE ACTIONS --%>
<spring:eval var="isVer"
	expression="detalleLicencia.action.equals(T(net.izfe.g330.driidentiflib.enums.Action).VER)" />
<spring:eval var="isAlta"
	expression="detalleLicencia.action.equals(T(net.izfe.g330.driidentiflib.enums.Action).ALTA)" />
<spring:eval var="isEditar"
	expression="detalleLicencia.action.equals(T(net.izfe.g330.driidentiflib.enums.Action).EDITAR)" />
<%-- END DETALLE ACTIONS --%>

<spring:eval var="estadosLicencia"
	expression="T(net.izfe.g370.drzlizentziaklib.enums.EstadoLicencia).values()" />
<spring:eval var="lugaresOperacion"
	expression="T(net.izfe.g370.drzlizentziaklib.enums.LugarOperacion).values()" />
<spring:eval var="tiposSolicitud"
	expression="T(net.izfe.g370.drzlizentziaklib.enums.TipoSolicitud).values()" />

<form:form action="" method="POST" modelAttribute="detalleLicencia"
	id="licenciaForm" autocomplete="off">
	<div id="baibot-content">
		<section class="baibot-toolbar">
			<div class="float-left">
				<c:if test="${esResolucionSolicitud}">
					<h1>
						<spring:message code="solicitud.ui.resolver" />
					</h1>
				</c:if>
				<c:if test="${!esResolucionSolicitud}">
					<c:choose>
						<c:when test="${isVer}">
							<h1>
								<spring:message code="licencia.ui.detalle" />
							</h1>
						</c:when>
						<c:when test="${isAlta}">
							<h1>
								<spring:message code="licencia.ui.alta" />
							</h1>
						</c:when>
						<c:when test="${isEditar}">
							<h1>
								<spring:message code="licencia.ui.editar" />
							</h1>
						</c:when>
					</c:choose>
				</c:if>
			</div>
			<c:if test="${!esResolucionSolicitud}">
				<div class="float-md-right">
					<span id="msgDuplicadoPendienteAbono" class="badge badge-warning mr-5 d-none"><spring:message code="licencia.ui.duplicadoPendienteAbono" /></span>
					<c:if test="${origenDetalleLicencia eq 'listaImprimirLicencia'}">
						<a href="<spring:url value="/lizentziak/eskaerak/inprimatu?clear=false"/>">
					</c:if>
					<c:if test="${origenDetalleLicencia eq 'listaLicencias' || origenDetalleLicencia eq 'detalleLicencia'}">
						<a href="<spring:url value="/lizentziak?clear=false"/>">
					</c:if>
						<button type="button" class="btn btn-light mr-1 mb-2 mb-sm-0">
							<em class="far fa-reply mr-2 align-middle"></em>
							<spring:message code="comun.ui.volver" />
						</button>
					</a>
					<c:if test="${!isVer}">
						<button type="submit"
							class="btn btn-primary mr-1 mb-2 mb-sm-0 btnGuardar">
							<em class="far fa-save mr-2 align-middle"></em>
							<spring:message code="comun.ui.guardar" />
						</button>
					</c:if>						
					<c:if test="${isVer and detalleLicencia.licencia.esta < 6 }">
						<button type="button" class="btn btn-secondary mr-1 mb-2 mb-sm-0">
							<em class="far fa-print mr-2 align-middle"></em>
							<spring:message code="licencia.ui.imprimirCartaAbono" />
						</button>
					</c:if>
					<c:if test="${isVer and detalleLicencia.licencia.esta eq 2}">
						<spring:url var="urlImpresionCorrectaLicencia" value="/lizentziak/eskaerak/inprimatu/${detalleLicencia.licencia.clic}?origen=detalleLicencia" />
						<input type="hidden" id="urlImpresionCorrectaLicencia" value="${urlImpresionCorrectaLicencia}" />
						<button id="btnImprimir" type="button" class="btn btn-secondary mr-1 mb-2 mb-sm-0" data-url="<spring:url value="/api/lizentziak/eskaerak/inprimatu/${detalleLicencia.licencia.clic}"/>" disabled>
							<i class="far fa-print mr-2 align-middle"></i><spring:message code="licencia.ui.imprimirTarjeta" />
						</button>
					</c:if>
				</div>
			</c:if>
			<c:if test="${esResolucionSolicitud}">
				<div class="float-md-right">
					<a href="<spring:url value="/lizentziak/eskaerak?clear=false"/>">
						<button type="button" class="btn btn-light mr-1 mb-2 mb-sm-0">
							<em class="far fa-reply mr-2 align-middle"></em>
							<spring:message code="comun.ui.volver" />
						</button>
					</a>
				</div>
			</c:if>
		</section>

		<div class="container-fluid">

			<jsp:include page="/WEB-INF/jsps/views/licencias/detalleError.jsp" />

			<form:hidden path="action" />
			<form:hidden path="licencia.numi" />
			<form:hidden path="licencia.enti" />
			<form:hidden path="licencia.clic" />
			<form:hidden path="licencia.esta" />

			<c:if test="${esResolucionSolicitud}">
				<fieldset class="form-group">
					<legend>
						<spring:message code="solicitud.ui.datos" />
					</legend>

					<div class="form-row">
						<div class="col-sm-4 col-md-3 col-xl-2">
							<div class="form-group">
								<label for="fechaSolicitud" class="baibot-label"><spring:message
										code="solicitud.ui.fecha" /></label>
								<div class="input-group date js-tempusdominus"
									id="datetimepickerFechaSolicitud" data-target-input="nearest">
									<fmt:formatDate value="${solicitud.fsol}"
										var="fechaSolicitudFormateado"
										pattern="${springRequestContext.locale.language == 'eu' ? 'yyyy/MM/dd' : 'dd/MM/yyyy'}" />
									<input type="text" class="form-control datetimepicker-input"
										data-target="#datetimepickerFechaSolicitud"
										id="fechaSolicitud" value="${fechaSolicitudFormateado}"
										disabled> <span class="input-group-append pt-1 pl-2"
										data-target="#datetimepickerFechaSolicitud"
										data-toggle="datetimepicker"> <i
										class="far fa-calendar-alt baibot-text-size-1-5 ml-1 text-primary"></i>
									</span>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-3 col-xl-2">
							<div class="form-group">
								<label for="selectTipoSolicitud" class="baibot-label"><spring:message
										code="solicitud.ui.tipo" /></label> <select
									class="form-control custom-select" id="selectTipoSolicitud"
									disabled>
									<c:forEach var="tipo" items="${tiposSolicitud}">
										<c:if test="${tipo.codigo eq solicitud.tsol}">
											<spring:message var="message" code="${tipo.descripcion}" />
											<option selected>${message}</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
				</fieldset>
			</c:if>

			<%String urlTag = "/WEB-INF/jsps/tags/fieldset.jsp"; %>
			<c:import url="<%=urlTag%>" context="/WAS/CORP/DRIIdentifWEB">
				<c:param name="action" value="${detalleLicencia.action}" />
				<c:param name="soloNuevo" value="false" />
				<c:param name="nombreDetalle" value="detalleLicencia" />
				<c:param name="nombreObjetoInputsContacto" value="licencia" />
			</c:import>

			<spring:url var="urlInhabilitacionPersona"
				value="/api/lizentziak/ezgaitua" />
			<input type="hidden" id="urlObtenerInhabilitacionPersona"
				value="${urlInhabilitacionPersona}" />
			<fieldset class="form-group d-none" id="datosInhabilitacion">
				<legend>
					<spring:message code="inhabilitado.ui.estadoPersona" />
				</legend>

				<div class="form-row">
					<div class="form-group">
						<div class="bg-danger text-white">
							<div class="p-3">
								<spring:message code="inhabilitado.ui.inhabilitado" />
							</div>
						</div>
					</div>
					<div class="col-6 col-sm-6 col-md-2 col-lg-2">
						<div class="form-group">
							<label for="" class="baibot-label-obligatorio"><spring:message
									code="inhabilitado.ui.fechaInhabilitacion" /></label> <input value=""
								type="text" disabled class="form-control"
								id="datosInhabilitacionFecha">
						</div>
					</div>
					<div class="col-6 col-sm-6 col-md-4 col-lg-4">
						<div class="form-group">
							<label for="" class="baibot-label-obligatorio"><spring:message
									code="inhabilitado.ui.motivo" /></label> <input
								value="Motivo Inhabilitación" type="text" class="form-control"
								disabled id="datosInhabilitacionMotivo">
						</div>
					</div>

				</div>
			</fieldset>

			<fieldset class="form-group">
				<legend>
					<spring:message code="licencia.ui.datos" />
				</legend>
				<div class="form-row">
					<div class="col-4 col-sm-3 col-md-2 col-lg-2">
						<div class="form-group">
							<spring:bind path="licencia.tlic">
								<div>
									<label for="tlic" class="baibot-label-obligatorio"><spring:message code="licencia.ui.tipo" /></label>
									<c:if test="${isVer}">
										<spring:eval var="tiposLicencia" expression="T(net.izfe.g370.drzlizentziaklib.enums.TipoLicencia).values()"/>
										<c:forEach var="tipo" items="${tiposLicencia}">
											<c:if test="${tipo.codigo eq detalleLicencia.licencia.tlic}">
												<spring:message var="message" code="${tipo.descripcion}"/>
											</c:if>
										</c:forEach>
										<input type="text" class="form-control" id="inputTipoLicencia" value="${message}" disabled >
									</c:if>
								</div>
								<c:if test="${!isVer}">
									<div class="custom-control custom-radio custom-control-inline radioLicencia">
										<form:radiobutton path="licencia.tlic" class="custom-control-input" cssErrorClass="custom-control-input is-invalid" id="radioCaza" value="1" disabled="${isEditar || isVer}" />
										<label for="radioCaza" class="custom-control-label ${empty status.errorMessage ? '' : 'is-invalid'}" data-toggle="tooltip" data-placement="top" data-html="true" data-original-title="${status.errorMessage}" >
											<spring:message code="licencia.caza" />
										</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline radioLicencia">
										<form:radiobutton path="licencia.tlic" class="custom-control-input" cssErrorClass="custom-control-input is-invalid" id="radioPesca" value="2" disabled="${isEditar || isVer}" />
										<label for="radioPesca" class="custom-control-label ${empty status.errorMessage ? '' : 'is-invalid'}" data-toggle="tooltip" data-placement="top" data-html="true" data-original-title="${status.errorMessage}" >
											<spring:message code="licencia.pesca" />
										</label>
									</div>
								</c:if>
							</spring:bind>
						</div>
					</div>
					<c:if test="${isVer || isEditar}">
						<div class="col-4 col-sm-4 col-md-3 col-lg-2">
							<div class="form-group">
								<form:input path="licencia.numl" class="d-none" /> 
								<spring:bind path="licencia.numc">
									<label for="licencia.numc" class="baibot-label"><spring:message
											code="licencia.ui.numTarjeta" /></label>
									<form:input type="text" path="licencia.numc"
										class="form-control" cssErrorClass="form-control is-invalid"
										readonly="true" data-toggle="tooltip" data-placement="top"
										data-html="true" data-original-title="${status.errorMessage}" />
								</spring:bind>
							</div>
						</div>
					</c:if>
					<div class="col-sm-4 col-md-3 col-xl-2">
						<div class="form-group">
							<form:hidden path="licencia.falt" />
							<label for="fAlta"><spring:message
									code="licencia.ui.fechaAlta" /></label>
							<spring:bind path="licencia.falt">
								<div id="fAlta" class="input-group date js-tempusdominus"
									data-target-input="nearest">
									<fmt:formatDate value="${detalleLicencia.licencia.falt}"
										var="fechaAltaFormateado"
										pattern="${springRequestContext.locale.language == 'eu' ? 'yyyy/MM/dd' : 'dd/MM/yyyy'}" />
									<input id="fech-input" type="text"
										class="form-control datetimepicker-input ${not empty status.errorMessage ? 'is-invalid' : ''}"
										data-target="#fech" ${isVer ? 'disabled' : ''}
										data-mask="${springRequestContext.locale.language == 'eu' ? '0000/00/00' : '00/00/0000'}"
										data-toggle="tooltip"
										data-original-title="${status.errorMessage}"
										value="${detalleLicencia.licencia.falt.time eq 253402210800000 ? '' : fechaAltaFormateado}"
										readonly /> <span class="input-group-append pt-1 pl-2"
										data-target="#fAlta" data-toggle="datetimepicker"> <em
										class="far fa-calendar-alt baibot-text-size-1-5 ml-1 text-primary"></em>
									</span>
								</div>
							</spring:bind>
						</div>
					</div>
					<c:if test="${isAlta}">
						<div class="col-sm-2 col-md-2 col-xl-2">
							<div class="form-group">
								<div class="baibot-label">
									<spring:message code="licencia.ui.cumpleRequisitos" />
								</div>
								<label for="switch-cumpleRequisitos"
									class="baibot-toggle-switch"> <input type="checkbox"
									class="switch-cumpleRequisitos" id="switch-cumpleRequisitos"
									value="${detalleLicencia.cumpleRequisitos}"<c:out value="${detalleLicencia.cumpleRequisitos ? 'checked' : ''}"/> ${isVer ? 'disabled' : ''}>
									<span id="switch-cumpleRequisitos"
									class="baibot-toggle-switch-slider"></span>
								</label>
								<form:input id="cumpleRequisitos" hidden="hidden"
									path="cumpleRequisitos" />
							</div>
						</div>
					</c:if>

					<c:if test="${isVer || isEditar}">
						<div class="col-sm-4 col-md-3 col-xl-2">
							<div class="form-group">
								<form:hidden path="licencia.ffin" />
								<label for="fFin"><spring:message
										code="licencia.ui.vigenteHasta" /></label>
								<spring:bind path="licencia.ffin">
									<div id="fFin" class="input-group date js-tempusdominus"
										data-target-input="nearest">
										<fmt:formatDate value="${detalleLicencia.licencia.ffin}"
											var="fechaVigenciaFormateado"
											pattern="${springRequestContext.locale.language == 'eu' ? 'yyyy/MM/dd' : 'dd/MM/yyyy'}" />
										<input id="fech-input" type="text"
											class="form-control datetimepicker-input ${not empty status.errorMessage ? 'is-invalid' : ''}"
											data-target="#fech" ${isVer ? 'disabled' : ''}
											data-mask="${springRequestContext.locale.language == 'eu' ? '0000/00/00' : '00/00/0000'}"
											data-toggle="tooltip"
											data-original-title="${status.errorMessage}"
											value="${detalleLicencia.licencia.ffin.time eq 253402210800000 ? '' : fechaVigenciaFormateado}"
											readonly /> <span class="input-group-append pt-1 pl-2"
											data-target="#fFin" data-toggle="datetimepicker"> <em
											class="far fa-calendar-alt baibot-text-size-1-5 ml-1 text-primary"></em>
										</span>
									</div>
								</spring:bind>
							</div>
						</div>
					</c:if>
					<div class="col-sm-2 col-md-2 col-lg-2 col-xl-2">
						<div class="form-group">
							<label for="" class="baibot-label text-left"><spring:message code="licencia.ui.estadoLicencia" /></label> 
							<span class="badge float-left" style="font-size: 1.3em" id="descEstadoLicencia"></span>
						</div>
					</div>
				</div>

				<c:if test="${not empty detalleLicencia.licencia.fbaj}">
					<div class="form-row">
						<div class="col-sm-4 col-md-3 col-xl-2">
							<div class="form-group">
								<label for="id05" class="baibot-label-obligatorio col-12 pl-0"><spring:message
										code="licencia.ui.fechaBaja" /></label>
								<fmt:formatDate value="${detalleLicencia.licencia.fbaj}"
									var="fechaBajaFormateado"
									pattern="${springRequestContext.locale.language == 'eu' ? 'yyyy/MM/dd' : 'dd/MM/yyyy'}" />
								<span class="badge badge-danger">${fechaBajaFormateado}</span>
							</div>
						</div>
						<div class="col-6 col-sm-6 col-md-3 col-lg-3">
							<div class="form-group">
								<label for="" class="baibot-label-obligatorio col-12 pl-0"><spring:message
										code="licencia.ui.motivoBaja" /></label> <span
									class="badge badge-danger"><c:out
										value="${detalleLicencia.licencia.mbaj}" /></span>
							</div>
						</div>
					</div>
				</c:if>
				<div class="form-row">
					<div class="col-12 col-sm-12 col-md-12 col-lg-12">
						<div class="form-group">
							<spring:bind path="licencia.obse">
								<label for="licencia.obse" class="baibot-label"><spring:message
										code="licencia.ui.observaciones" /></label>
								<form:input type="text" path="licencia.obse"
									class="form-control" cssErrorClass="form-control is-invalid" readonly="${isVer}" data-toggle="tooltip" data-placement="top" data-html="true" data-original-title="${status.errorMessage}" />
							</spring:bind>
						</div>
					</div>
				</div>
			</fieldset>
			<fieldset class="form-group">
				<legend>
					<spring:message code="pago.ui.datos" />
				</legend>
				<div class="form-row">
					<div class="col-6 col-sm-6 col-md-4 col-lg-4">
						<div class="form-group">
							<spring:bind path="licencia.mpag">
								<div class="baibot-label-obligatorio">
									<spring:message code="pago.ui.modo" />
									<c:if test="${isVer}">
										<spring:eval var="tiposLicencia" expression="T(net.izfe.g370.drzlizentziaklib.enums.TipoLicencia).values()"/>
										<c:forEach var="lugar" items="${lugaresOperacion}">
											<c:if test="${lugar.codigo eq detalleLicencia.licencia.mpag}">
												<spring:message var="messageMpag" code="${lugar.descripcion}" />
											</c:if>
										</c:forEach>
										<input type="text" class="form-control" id="inputTipoLicencia" value="${messageMpag}" disabled >
									</c:if>
								</div>
								<c:if test="${!isVer}">
									<div class="custom-control custom-radio custom-control-inline">
										<form:radiobutton path="licencia.mpag" class="custom-control-input radioModoPago" cssErrorClass="custom-control-input radioModoPago is-invalid" id="radioDomic" value="1" disabled="${isVer}" onchange='showDivModoPago();' />
										<label class="custom-control-label ${empty status.errorMessage ? '' : 'is-invalid'}" data-toggle="tooltip" data-placement="top" data-html="true" data-original-title="${status.errorMessage}" for="radioDomic">
											<spring:message code="pago.modo.domiciliacion" />
										</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
										<form:radiobutton path="licencia.mpag" class="custom-control-input radioModoPago" cssErrorClass="custom-control-input radioModoPago is-invalid" id="radioAbono" value="2" disabled="${isVer}" onchange='showDivModoPago();' />
										<label class="custom-control-label ${empty status.errorMessage ? '' : 'is-invalid'}" data-toggle="tooltip" data-placement="top" data-html="true" data-original-title="${status.errorMessage}" for="radioAbono">
											<spring:message code="pago.modo.cartaAbono" />
										</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
										<form:radiobutton path="licencia.mpag" class="custom-control-input radioModoPago" cssErrorClass="custom-control-input radioModoPago is-invalid" id="radioOnline" value="3" disabled="${isVer}" onchange='showDivModoPago();' />
										<label class="custom-control-label ${empty status.errorMessage ? '' : 'is-invalid'}" data-toggle="tooltip" data-placement="top" data-html="true" data-original-title="${status.errorMessage}" for="radioOnline">
											<spring:message code="pago.modo.pagoOnline" />
										</label>
									</div>
								</c:if>
							</spring:bind>
						</div>
					</div>
					<div class="col-6 d-none" id="datosDomiciliacion">
						<div class="form-row">
							<div class="col-9 rowLicenciaNueva">
								<label for="textoCuentaSesion" class="baibot-label-obligatorio"><spring:message code="licencia.ui.numeroCuenta" /></label>
								<spring:url var="urlCuentaSesion" value="/api/lizentziak/sesioKontua" />
								<input type="hidden" id="urlObtenerCuentaSesion" value="${urlCuentaSesion}" /> 
								<c:set var="cuentaErrors"><form:errors path="licencia.ccte"/></c:set>
								<input type="text" class="form-control ${not empty cuentaErrors ? 'is-invalid' : ''}" id="textoCuentaSesion" readonly>
							</div>
							<div class="col-9 selectDatoBancario">
								<div class="form-group">
									<input type="hidden" id="codCuentaPersona" value="${detalleLicencia.licencia.ccte}" />
									<spring:url var="urlCuentasBancarias" value="/api/lizentziak/bankuKontuak" />
									<input type="hidden" id="urlObtenerCuentasBancarias" value="${urlCuentasBancarias}" />
									<label for="selectCuenta" class="baibot-label-obligatorio"><spring:message code="licencia.ui.numeroCuenta" /></label>
									<form:select class="form-control custom-select elemDisabled" cssErrorClass="form-form-control custom-select elemDisabled is-invalid"
										path="licencia.ccte" id="selectCuenta" disabled="true"
										data-toggle="tooltip" data-placement="top" data-html="true" data-original-title="${status.errorMessage}" >
									</form:select>
								</div>
							</div>
							<div class="col-3 mt-4">
								<button type="button" class="btn btn-primary mt-1 elemDisabled botonAltaDatoBancario" style="border-radius: 0.2rem;" data-toggle="modal" data-target=".js-altaCuenta-modal" disabled>
									<i class="far fa-plus align-middle"></i>
<%-- 									<span class="btnAltaDatoBancario ml-2"><spring:message code="banco.ui.aniadir" /></span> --%>
								</button>
							</div>
						</div>
					</div>
					<div class="col-6 col-sm-6 col-md-4 col-lg-3 d-none"
						id="datosCartaAbono">
						<!-- 						<div class="form-group"> -->
						<!-- 							<button type="button" class="btn btn-primary mr-1"><i class="far fa-eye mr-2 align-middle"></i>Imprimir carta de abono</button> -->
						<!-- 						</div> -->
					</div>
				</div>

				<c:if test="${!esResolucionSolicitud and isVer}">
					<div class="table-responsive">
						<table
							class="table table-bordered table-striped table-hover js-datatable d-none"
							id="tablaPagos"
							data-url="<spring:url value="/api/lizentziak/ordainketak/${detalleLicencia.licencia.clic}/dt"/>">
							<colgroup>
								<col style="width: 25%;">
								<col style="width: 25%;">
								<col style="width: 25%;">
								<col style="width: 25%;">
							</colgroup>
							<thead>
								<tr>
									<th><spring:message code="pago.ui.fechaAbono" /></th>
									<th><spring:message code="pago.ui.centroExpedicion" /></th>
									<th><spring:message code="tasa.ui.tipo" /></th>
									<th><spring:message code="tasa.ui.importe" /></th>
								</tr>
							</thead>
						</table>
					</div>
					<spring:eval var="tiposTasa" expression="T(net.izfe.g370.drzlizentziaklib.enums.TipoTasa).values()" />
					<c:forEach var="tipoTasa" items="${tiposTasa}">
						<spring:message var="message" code="${tipoTasa.descripcion}" />
						<input type="hidden" id="tipoTasa-${tipoTasa.codigo}" value="${message}" />
					</c:forEach>
				</c:if>
			</fieldset>
			<fieldset class="form-group">
				<legend>
					<spring:message code="documento.ui.documentos" />
				</legend>
				<div id="baibot-datatables-acciones" class="baibot-datatables-acciones-y-filtro">
					<c:if test="${isVer}">
						<button id="btn-ver" type="button"
							class="btn btn-primary mr-1 mb-2"
							data-url="<spring:url value="/lizentziak/dokumentua/ikusi/{0}"/>"
							disabled>
							<i class="far fa-file-plus mr-2 align-middle"></i>
							<spring:message code="comun.ui.ver" />
						</button>
					</c:if>
					<c:if test="${!isVer}">
						<button type="button" class="btn btn-primary mr-1 mb-2"
							data-toggle="modal" data-target=".js-aniadirDocumento-modal">
							<i class="far fa-file-plus mr-2 align-middle"></i>
							<spring:message code="comun.ui.aniadirDocumento" />
						</button>
						<button id="btn-delete" type="button"
							class="btn btn-danger mr-1 mb-2" disabled>
							<i class="far fa-trash-alt mr-2 align-middle"></i>
							<spring:message code="comun.ui.eliminar" />
						</button>
					</c:if>

					<span class="badge badge-danger ml-5"><spring:message
							code="comun.ui.datosSensibles" /></span>
				</div>
				<div class="table-responsive">
					<table
						class="table table-bordered table-striped table-hover js-tablaAdjuntos d-none">
						<thead>
							<tr>
								<th><spring:message code="comun.ui.docsAdjuntos" /></th>
								<th><spring:message code="comun.ui.fecha" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${documentosSesion}" var="documento"
								varStatus="loop">
								<c:if test="${!documento.eliminado}">
									<tr data-id="${!isVer ? loop.index : documento.cdoc}">
										<td><c:out value="${documento.descripcion}" /></td>
										<fmt:formatDate value="${documento.fechaVal}"
											pattern="${springRequestContext.locale.language == 'eu' ? 'yyyy/MM/dd' : 'dd/MM/yyyy'}"
											var="fechaFormateada" />
										<td>${fechaFormateada}</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</fieldset>
			<c:if test="${!esResolucionSolicitud}">
				<section class="baibot-toolbar baibot-toolbar-abajo">
					<div class="float-md-right">
					<c:if test="${origenDetalleLicencia eq 'listaImprimirLicencia'}">
						<a href="<spring:url value="/lizentziak/eskaerak/inprimatu?clear=false"/>">
					</c:if>
					<c:if test="${origenDetalleLicencia eq 'listaLicencias' || origenDetalleLicencia eq 'detalleLicencia'}">
						<a href="<spring:url value="/lizentziak?clear=false"/>">
					</c:if>
							<button type="button" class="btn btn-light mr-1 mb-2 mb-sm-0">
								<em class="far fa-reply mr-2 align-middle"></em>
								<spring:message code="comun.ui.volver" />
							</button>
						</a>
						<c:if test="${!isVer}">
							<button type="submit" class="btn btn-primary mr-1 mb-2 mb-sm-0">
								<em class="far fa-save mr-2 align-middle"></em>
								<spring:message code="comun.ui.guardar" />
							</button>
						</c:if>
					</div>
				</section>
			</c:if>
			<c:if test="${esResolucionSolicitud}">
				<section class="baibot-toolbar baibot-toolbar-abajo">
					<div class="float-md-right">
						<a href="<spring:url value="/lizentziak/eskaerak?clear=false"/>">
							<button type="button" class="btn btn-light mr-1 mb-2 mb-sm-0">
								<em class="far fa-reply mr-2 align-middle"></em>
								<spring:message code="comun.ui.volver" />
							</button>
						</a>
					</div>
				</section>
			</c:if>
			<c:if test="${esResolucionSolicitud and empty solicitud.fres}">
				<div class="d-flex justify-content-center mb-3">
					<a
						href="<spring:url value="/lizentziak/eskaerak/${solicitud.csol}/onartu"/>">
						<button type="button" class="btn btn-success mr-1 p-2 pl-5 pr-5"
							id="btnAprobarSolicitud">
							<span style="font-size: 1.3em"><spring:message
									code="solicitud.ui.aprobar" /></span>
						</button>
					</a>
					<button type="button" class="btn btn-danger mr-1 p-2 pl-5 pr-5"
						data-toggle="modal" data-target=".js-denegarSolicitud-modal">
						<span style="font-size: 1.3em"><spring:message
								code="solicitud.ui.denegar" /></span>
					</button>
				</div>
			</c:if>
		</div>
	</div>
</form:form>

<%-- <%String urlTagModal = "/WEB-INF/jsps/tags/modals.jsp"; %> --%>
<%-- <c:import url="<%=urlTagModal%>" context="/WAS/CORP/DRIIdentifWEB"> --%>
<%-- </c:import> --%>

<c:forEach var="estado" items="${estadosLicencia}">
	<spring:message var="message" code="${estado.descripcion}" />
	<input type="hidden" class="${estado.badge}"
		id="estadoLicencia-${estado.codigo}" value="${message}" />
</c:forEach>
<c:forEach var="lugar" items="${lugaresOperacion}">
	<spring:message var="message" code="${lugar.descripcion}" />
	<input type="hidden" id="lugarOperacion-${lugar.codigo}"
		value="${message}" />
</c:forEach>

<div class="modal fade js-altaCuenta-modal" tabindex="-1"
	id="modalAltaCuenta">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<p class="modal-title">
					<strong><spring:message code="individuo.ui.seleccionar" /></strong>
				</p>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body pt-1">
				<spring:url var="actionAltaCuenta"
					value="/api/lizentziak/bankuKontuak" />
				<input type="hidden" id="urlAltaCuenta" value="${actionAltaCuenta}">
				<form:form action="#" method="POST" modelAttribute="cuenta"
					id="cuentaForm" enctype="multipart/form-data" autocomplete="off">
					<form:hidden path="enti" />
					<form:hidden path="numi" />
					<form:hidden path="nump" />

					<div class="form-row">
						<div class="col-sm-5 col-lg-5">
							<div class="form-group">
								<spring:bind path="iban">
									<label for="iban" class="baibot-label-obligatorio"><spring:message
											code="banco.ui.iban" /></label>
									<form:input type="text" path="iban" class="form-control"
										cssErrorClass="form-control is-invalid" readonly="${VIEW}"
										maxlength="29" data-toggle="tooltip" data-placement="top"
										data-html="true" data-original-title="${status.errorMessage}" />
								</spring:bind>
							</div>
						</div>
						<div class="col-sm-7 col-lg-7">
							<div class="form-group">
								<label for="exampleInputFile"><spring:message
										code="banco.ui.documento" /></label>
								<div class="input-group">
									<label class="input-group-prepend mb-0"> <span
										class="btn btn-primary"> <spring:message
												code="documento.ui.elegirArchivo" /><input id="file"
											name="file" type="file" style="display: none;" />
									</span>
									</label> <input type="text" class="form-control" id="inputFile"
										readonly />
								</div>
							</div>
						</div>
					</div>
					<div class="form-row">
						<div class="col">
							<div class="form-group">
								<spring:bind path="obse">
									<label for="obse" class="baibot-label"><spring:message
											code="banco.ui.observaciones" /></label>
									<form:textarea path="obse" class="form-control"
										cssErrorClass="form-control is-invalid" readonly="${VIEW}"
										rows="4" data-toggle="tooltip" data-placement="top"
										data-html="true" data-original-title="${status.errorMessage}" />
								</spring:bind>
							</div>
						</div>
					</div>
				</form:form>
			</div>
			<div class="modal-footer pr-4">
				<button type="button" class="btn btn-light" data-dismiss="modal">
					<i class="far fa-times mr-2 align-middle"></i>
					<spring:message code="comun.ui.cancelar" />
				</button>
				<button type="button" class="btn btn-primary btnGuardar"
					id="guardarCuenta">
					<i class="far fa-check mr-2 align-middle"></i>
					<spring:message code="comun.ui.guardar" />
				</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade js-aniadirDocumento-modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<p class="modal-title">
					<strong><spring:message code="documento.ui.aniadir" /></strong>
				</p>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<spring:url var="actionDoc" value="/lizentziak/dokumentua" />
			<input type="hidden" id="urlPostDoc" value="${actionDoc}">
			<form:form action="${actionDoc}" method="POST"
				modelAttribute="documento" enctype="multipart/form-data"
				id="documentoForm">
				<div class="modal-body">
					<div class="form-row">
						<div class="form-group col-12">
							<label for="id01" class="baibot-label-obligatorio"><spring:message
									code="comun.ui.descripcion" /></label>
							<form:input path="desc" type="text" class="form-control" />
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-12">
							<label for="documentoInputFile"><spring:message
									code="comun.ui.documento" /></label>
							<div class="input-group">
								<label class="input-group-prepend mb-0"> <span
									class="btn btn-primary"> <spring:message
											code="comun.ui.elegirArchivo" /><input id="file" name="file"
										type="file" style="display: none;" />
								</span>
								</label> <input type="text" class="form-control" id="docInputFile"
									readonly />
							</div>
						</div>
					</div>
				</div>
				<div
					class="modal-footer justify-content-center justify-content-sm-end pr-sm-4">
					<button type="button" class="btn btn-light" data-dismiss="modal">
						<i class="far fa-times mr-2 align-middle"></i>
						<spring:message code="comun.ui.cancelar" />
					</button>
					<button type="button" class="btn btn-primary" id="btnSubmit">
						<i class="far fa-search mr-2 align-middle"></i>
						<spring:message code="comun.ui.guardar" />
					</button>
				</div>
			</form:form>
		</div>
	</div>
</div>
<spring:url var="actionDeleteDoc"
	value="/lizentziak/dokumentua/ezabatu/" />
<input type="hidden" id="urlDeleteDoc" value="${actionDeleteDoc}">
<div class="modal fade js-deleteDocomento-modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<p class="modal-title">
					<strong><spring:message code="comun.ui.eliminarRegistro" /></strong>
				</p>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<p class="text-primary text-center mt-4 mb-4">
					<strong><spring:message
							code="comun.ui.comfirmEliminarRegistro" /></strong>
				</p>
			</div>
			<div class="modal-footer pr-4">
				<button type="button" class="btn btn-light" data-dismiss="modal">
					<i class="far fa-times mr-2 align-middle"></i>
					<spring:message code="comun.ui.cancelar" />
				</button>
				<button id="btn-delete-confirmed" type="button"
					class="btn btn-primary">
					<i class="far fa-check mr-2 align-middle"></i>
					<spring:message code="comun.ui.aceptar" />
				</button>
			</div>
		</div>
	</div>
</div>
<c:if test="${esResolucionSolicitud}">
	<div class="modal fade js-denegarSolicitud-modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<p class="modal-title">
						<strong><spring:message code="solicitud.ui.denegar" /></strong>
					</p>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<spring:url var="actionSolicitud"
					value="/lizentziak/eskaerak/${solicitud.csol}/ukatu" />
				<input type="hidden" id="urlPostDenegarSolicitud"
					value="${actionSolicitud}">
				<form:form action="${actionSolicitud}" method="POST"
					modelAttribute="solicitud" enctype="multipart/form-data"
					id="denegarSolicitudForm">
					<div class="modal-body">
						<div class="form-row">
							<div class="col">
								<div class="form-group">
									<spring:bind path="otrd">
										<label for="obse" class="baibot-label"><spring:message
												code="solicitud.ui.motivoDenegar" /></label>
										<form:textarea path="otrd" class="form-control"
											cssErrorClass="form-control is-invalid" rows="4"
											data-toggle="tooltip" data-placement="top" data-html="true"
											data-original-title="${status.errorMessage}" />
									</spring:bind>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer pr-4">
						<button type="button" class="btn btn-light" data-dismiss="modal">
							<i class="far fa-times mr-2 align-middle"></i>
							<spring:message code="comun.ui.cancelar" />
						</button>
						<button type="button" class="btn btn-primary"
							id="btnSubmitDenegacion">
							<i class="far fa-search mr-2 align-middle"></i>
							<spring:message code="comun.ui.guardar" />
						</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</c:if>

<div class="modal fade js-impresionCorrecta-modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <p class="modal-title"><strong><spring:message code="solicitud.ui.impresionCorrecta" /></strong></p>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    					<span aria-hidden="true">&times;</span>
    				</button>
            </div>
            <div class="modal-body">
                <p class="text-primary text-center mt-4 mb-4"><strong><spring:message code="solicitud.ui.impresionCorrectaMsg" /></strong></p>
            </div>
            <div class="modal-footer pr-4">
                <button type="button" class="btn btn-light" data-dismiss="modal"><i class="far fa-times mr-2 align-middle"></i><spring:message code="comun.ui.no" /></button>
                <button id="btn-impresionCorrecta-confirmed" type="button" class="btn btn-primary">
                	<i class="far fa-check mr-2 align-middle"></i><spring:message code="comun.ui.si" />
                	<span id="count"></span>
               	</button>
            </div>
        </div>
    </div>
</div>

<script>
	$(document)
			.ready(
					function() {
						var oTableDocs = $('.js-tablaAdjuntos').DataTable({
							"language" : {
								url : dtLanguage[language]
							},
							"dom" : '<"top"f>rt<"bottom"ilp><"clear">',
							"columns" : [ // Campos no ordenables
							null, null ]
						});

						oTableDocs.order([]).draw();

						oTableDocs.on('init.dt', function() {
							$('.js-tablaAdjuntos').removeClass('d-none');
						});

						$('#btn-ver').click(function() {
							var docSeleccionado = $.map(oTableDocs.rows('.selected').nodes(), function (item) {
				        	    return $(item).data("id");
				        	});
				  			window.location = String.format($(this).attr("data-url"), docSeleccionado);
						});
						
						$('#btn-delete').click(function() {
							$(".js-deleteDocomento-modal").modal(); // Abrimos ventana modal de eliminación
						});

						$('.js-tablaAdjuntos tbody').on('click', 'tr',
								function() {
									$(this).toggleClass('selected');
									$(this).checkControlStatus();
								});

						$.fn.checkControlStatus = function() {
							if ($('.js-tablaAdjuntos tbody tr').hasClass(
									'selected')) {
								if ($('.js-tablaAdjuntos tbody tr.selected').length == 1) {
									$('#btn-ver').attr("disabled", false);
									$('#btn-delete').attr("disabled", false);
								} else {
									$('#btn-ver').attr("disabled", true);
									$('#btn-delete').attr("disabled", true);
								}
							} else {
								// Si no hay filas seleccionadas, desactivamos todos los botones
								$('#btn-ver').attr("disabled", true);
								$('#btn-delete').attr("disabled", true);
							}
							return this;
						};

						$("#btnSubmit")
								.click(
										function(event) {
											event.preventDefault();

											var errorEnFormulario = false;
											if ($("#desc").val().length == 0) {
												errorEnFormulario = true;
												$("#desc")
														.attr("class",
																"form-control js-autosize is-invalid");
											} else {
												$("#desc")
														.attr("class",
																"form-control js-autosize");
											}
											if ($("#docInputFile").val().length == 0) {
												errorEnFormulario = true;
												$("#docInputFile")
														.attr("class",
																"form-control js-autosize is-invalid");
											} else {
												$("#docInputFile")
														.attr("class",
																"form-control js-autosize");
											}
											if (!errorEnFormulario) {
												var form = $('#documentoForm')[0];
												var data = new FormData(form);

												$
														.ajax({
															type : "POST",
															enctype : 'multipart/form-data',
															url : $(
																	'#urlPostDoc')
																	.val(),
															data : data,
															processData : false,
															contentType : false,
															cache : false,
															timeout : 600000,
															success : function(
																	data) {
																console
																		.log(
																				"SUCCESS : ",
																				data);
																var numFila = oTableDocs
																		.rows()
																		.count();
																var i = oTableDocs.row
																		.add(
																				[
																						data.desc,
																						moment(
																								data.fval)
																								.format(
																										dateFormat[language]) ])
																		.index();
																oTableDocs
																		.draw(false);
																oTableDocs
																		.rows(i)
																		.nodes()
																		.to$()
																		.attr(
																				"data-id",
																				numFila);
																$(
																		'.js-aniadirDocumento-modal')
																		.modal(
																				'hide');
															},
															error : function(e) {
																console
																		.log(
																				"ERROR : ",
																				e);
															}
														});
											}
										});

						$('.js-aniadirDocumento-modal').on(
								'hidden.bs.modal',
								function() {
									$("#desc").attr("class",
											"form-control js-autosize");
									$("#docInputFile").attr("class",
											"form-control js-autosize");

									$("#desc").val("");
									$("#inputFile").val("");
									$("#docInputFile").val("");
								});

						/* ================================================================== */
						/* *********************** ELIMINAR DOCUMENTOS ********************** */
						/* ================================================================== */
						$("#btn-delete-confirmed").click(
								function(event) {
									var docSeleccionado = $.map(oTableDocs
											.rows('.selected').nodes(),
											function(item) {
												return $(item).data("id");
											});

									$.ajax({
										type : "POST",
										url : $('#urlDeleteDoc').val()
												+ docSeleccionado,
										processData : false,
										contentType : false,
										cache : false,
										timeout : 600000,
										success : function(data) {
											oTableDocs.rows('.selected')
													.remove().draw();
											$('.js-deleteDocomento-modal')
													.modal('hide');
										},
										error : function(e) {
										}
									});
								});

						/* ================================================================== */
						/* ************************ DATOS DE PERSONA ************************ */
						/* ================================================================== */

						inicializarSelectCuentaPersona();
						comprobarInhabilitacionPersona();
						function indicarEstadoLicencia() {
							var estado = '${detalleLicencia.licencia.esta}';
							$("#descEstadoLicencia").text(
									$("#estadoLicencia-" + estado).val());
							$("#descEstadoLicencia").addClass(
									$("#estadoLicencia-" + estado)
											.attr("class"));
						}
						indicarEstadoLicencia();
						showDivModoPago();
						switchPersonaRegistrada();

						$(document).on('click',
								'button[id="seleccionarPersona"]',
								function(event) {
									inicializarSelectCuentaPersona();
									comprobarInhabilitacionPersona();
								});

						function inicializarSelectCuentaPersona() {
							if ($("#numiPersonaRegistrada").val() != null
									&& $("#numiPersonaRegistrada").val() != ""
									&& $("#entiPersonaRegistrada").val() != null
									&& $("#entiPersonaRegistrada").val() != "") {
								$("#selectCuenta").html("");
								$
										.ajax({
											url : $(
													"#urlObtenerCuentasBancarias")
													.val()
													+ "/"
													+ $(
															"#numiPersonaRegistrada")
															.val()
													+ "/"
													+ $(
															"#entiPersonaRegistrada")
															.val(),
											success : function(data) {
												$("#selectCuenta").append(
														"");
												data
														.forEach(function(
																cuenta, cont) {
															if (cuenta.nban == $(
																	"#codCuentaPersona")
																	.val()) {
																$(
																		"#selectCuenta")
																		.append(
																				'<option value="' + cuenta.nban + '" selected>'
																						+ cuenta.iban
																						+ '</option>');
															} else {
																$(
																		"#selectCuenta")
																		.append(
																				'<option value="' + cuenta.nban + '">'
																						+ cuenta.iban
																						+ '</option>');
															}
														});
											},
											error : function(x, e) {

											}
										});
							} else {
					    		$.ajax({
									url : $("#urlObtenerCuentaSesion").val(),
									success: function (data) {
										$("#textoCuentaSesion").val(data);
									},
									error : function(x, e) {
						
									}
								});
					    	}
						}
						
						function inicializarSelectCuentaPersonaSelected(valorSelected) {
							if ($("#numiPersonaRegistrada").val() != null
									&& $("#numiPersonaRegistrada").val() != ""
									&& $("#entiPersonaRegistrada").val() != null
									&& $("#entiPersonaRegistrada").val() != "") {
								$("#selectCuenta").html("");
								$
										.ajax({
											url : $(
													"#urlObtenerCuentasBancarias")
													.val()
													+ "/"
													+ $(
															"#numiPersonaRegistrada")
															.val()
													+ "/"
													+ $(
															"#entiPersonaRegistrada")
															.val(),
											success : function(data) {
												$("#selectCuenta").append(
														"<option></option>");
												data
														.forEach(function(
																cuenta, cont) {
															if (cuenta.nban == valorSelected) {
																$(
																		"#selectCuenta")
																		.append(
																				'<option value="' + cuenta.nban + '" selected>'
																						+ cuenta.iban
																						+ '</option>');
															} else {
																$(
																		"#selectCuenta")
																		.append(
																				'<option value="' + cuenta.nban + '">'
																						+ cuenta.iban
																						+ '</option>');
															}
														});
											},
											error : function(x, e) {

											}
										});
							} else {
					    		$.ajax({
									url : $("#urlObtenerCuentaSesion").val(),
									success: function (data) {
										$("#textoCuentaSesion").val(data);
									},
									error : function(x, e) {
						
									}
								});
					    	}
						}

						function comprobarInhabilitacionPersona() {
							if ($("#numiPersonaRegistrada").val() != null
									&& $("#numiPersonaRegistrada").val() != ""
									&& $("#entiPersonaRegistrada").val() != null
									&& $("#entiPersonaRegistrada").val() != "") {
								$
										.ajax({
											url : $(
													"#urlObtenerInhabilitacionPersona")
													.val()
													+ "/"
													+ $(
															"#numiPersonaRegistrada")
															.val()
													+ "/"
													+ $(
															"#entiPersonaRegistrada")
															.val(),
											success : function(data) {
												var estaInhabilitado = false;
												var inhabilitacionEnCurso;
												data
														.forEach(function(
																inhabilitacion,
																cont) {
															console
																	.log(inhabilitacion);
															var currentDate = new Date();
															if (currentDate > inhabilitacion.fIni
																	&& currentDate < inhabilitacion.fFin) {
																estaInhabilitado = true;
																inhabilitacionEnCurso = inhabilitacion;
																return false;
															}
														});
												if (estaInhabilitado) {
													$("#datosInhabilitacion")
															.removeClass(
																	"d-none");
													var fechaInhab = new Date(
															inhabilitacionEnCurso.fIni);
													$(
															"#datosInhabilitacionFecha")
															.val(
																	fechaInhab
																			.getDate()
																			+ '/'
																			+ (fechaInhab
																					.getMonth() + 1)
																			+ '/'
																			+ fechaInhab
																					.getFullYear());
													$(
															"#datosInhabilitacionMotivo")
															.val(
																	inhabilitacionEnCurso.nombreMotivo);
													$(".btnGuardar").attr(
															"disabled", "true");
													if ('${esResolucionSolicitud}'
															&& '${solicitud.tsol}' == 1) {
														$(
																"#btnAprobarSolicitud")
																.attr(
																		"disabled",
																		"true");
													}
												} else {
													$("#datosInhabilitacion")
															.addClass("d-none");
													$(
															"#datosInhabilitacionFecha")
															.val("");
													$(
															"#datosInhabilitacionMotivo")
															.val("");
													$(".btnGuardar")
															.removeAttr(
																	"disabled");
												}
											},
											error : function(x, e) {

											}
										});
							}
						}

						$(document)
								.on(
										'click',
										'#guardarCuenta',
										function() {
											$("#cuentaForm input[name=numi]")
													.val(
															$(
																	"#numiPersonaRegistrada")
																	.val() != "" ? $(
																	"#numiPersonaRegistrada")
																	.val()
																	: 0);
											$("#cuentaForm input[name=enti]")
													.val(
															$(
																	"#entiPersonaRegistrada")
																	.val() != "" ? $(
																	"#entiPersonaRegistrada")
																	.val()
																	: 0);

											var formAltaCuenta = $('#cuentaForm')[0];
											var dataAltaCuenta = new FormData(
													formAltaCuenta);

											var urlPostCuenta = $(
													'#urlAltaCuenta').val();
											if ($("#numiPersonaRegistrada")
													.val() != ""
													&& $(
															"#entiPersonaRegistrada")
															.val() != "") {
												urlPostCuenta = urlPostCuenta
														+ "/"
														+ $(
																"#numiPersonaRegistrada")
																.val()
														+ "/"
														+ $(
																"#entiPersonaRegistrada")
																.val();
											}
											urlPostCuenta = urlPostCuenta
													+ "/berria";

											$
													.ajax({
														type : "POST",
														enctype : 'multipart/form-data',
														url : urlPostCuenta,
														data : dataAltaCuenta,
														processData : false,
														contentType : false,
														cache : false,
														timeout : 600000,
														beforeSend : function() {
															$(".js-spin")
																	.show();
														},
														success : function(data) {
															inicializarSelectCuentaPersonaSelected(data.nban);
															$(
																	'#modalAltaCuenta')
																	.modal(
																			'hide');
														},
														error : function(e) {
															e.responseJSON
																	.forEach(function(
																			errorValidacion,
																			cont) {
																		$(
																				"#"
																						+ errorValidacion.field)
																				.addClass(
																						"is-invalid");
																		if (errorValidacion.defaultMessage != null
																				&& errorValidacion.defaultMessage != "") {
																			$(
																					"#"
																							+ errorValidacion.field)
																					.attr(
																							'data-original-title',
																							errorValidacion.defaultMessage)
																					.tooltip(
																							'show');
																			;
																		}
																	});
														}
													});
										});
					});

	$("#registrado").on("input", function() {
		switchPersonaRegistrada();
	});

	var isEditar = '${isEditar}';
	var isVer = '${isVer}';

	function switchPersonaRegistrada() {
		var registrado = $('#registrado').val() == 1 || $('#registrado').val() == "true";
		if (registrado) {
			if ($("#numiPersonaRegistrada").val() != ""
					&& $("#entiPersonaRegistrada").val() != "") {
				$(".botonAltaDatoBancario").removeAttr("disabled");
			} else {
				$(".botonAltaDatoBancario").attr("disabled", "true");
			}
			$(".selectDatoBancario").removeClass("d-none");
			$(".rowLicenciaNueva").addClass("d-none");
		} else {
			$(".botonAltaDatoBancario").removeAttr("disabled");
			$(".selectDatoBancario").addClass("d-none");
			$(".rowLicenciaNueva").removeClass("d-none");
		}
		if (isEditar == "true") {
			$(".botonAltaDatoBancario").removeAttr("disabled");
			$(".selectDatoBancario").removeClass("d-none");
			$(".rowLicenciaNueva").addClass("d-none");
			$(".elemDisabled").removeAttr("disabled");
		}
		if (isVer == "true") {
			$(".selectDatoBancario").removeClass("d-none");
			$(".rowLicenciaNueva").addClass("d-none");
			$(".botonAltaDatoBancario").attr("disabled", "true");
		}
	}

	function showDivModoPago() {
		var tipoAbono = $('input.radioModoPago:checked').val();
		if (tipoAbono == 1) {
			$("#datosDomiciliacion").removeClass("d-none");
			$("#datosCartaAbono").addClass("d-none");
		} else if (tipoAbono == 2) {
			$("#datosDomiciliacion").addClass("d-none");
			$("#datosCartaAbono").removeClass("d-none");
		} else {
			$("#datosDomiciliacion").addClass("d-none");
			$("#datosCartaAbono").addClass("d-none");
		}
	}
	
	$(document).on('submit','#licenciaForm',function(){
		$(".custom-control-input").removeAttr("disabled");
	});
</script>

<script
	src="<spring:url value="/estatico/js/licencias/detalleLicencia.js"/>"></script>
	<script src="<spring:url value="/estatico/js/comun/tablaPagos.js"/>"></script>