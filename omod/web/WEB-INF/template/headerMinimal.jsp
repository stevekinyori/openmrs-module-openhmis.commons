<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%--
  ~ The contents of this file are subject to the OpenMRS Public License
  ~ Version 2.0 (the "License"); you may not use this file except in
  ~ compliance with the License. You may obtain a copy of the License at
  ~ http://license.openmrs.org
  ~
  ~ Software distributed under the License is distributed on an "AS IS"
  ~ basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
  ~ License for the specific language governing rights and limitations
  ~ under the License.
  ~
  ~ Copyright (C) OpenMRS, LLC.  All Rights Reserved.
  --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page import="org.openmrs.web.WebConstants" %>
<%
	pageContext.setAttribute("msg", session.getAttribute(WebConstants.OPENMRS_MSG_ATTR));
	pageContext.setAttribute("msgArgs", session.getAttribute(WebConstants.OPENMRS_MSG_ARGS));
	pageContext.setAttribute("err", session.getAttribute(WebConstants.OPENMRS_ERROR_ATTR));
	pageContext.setAttribute("errArgs", session.getAttribute(WebConstants.OPENMRS_ERROR_ARGS));
	session.removeAttribute(WebConstants.OPENMRS_MSG_ATTR);
	session.removeAttribute(WebConstants.OPENMRS_MSG_ARGS);
	session.removeAttribute(WebConstants.OPENMRS_ERROR_ATTR);
	session.removeAttribute(WebConstants.OPENMRS_ERROR_ARGS);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<openmrs:htmlInclude file="/openmrs.js"/>
	<openmrs:htmlInclude file="/scripts/openmrsmessages.js" appendLocale="true"/>
	<openmrs:htmlInclude file="/openmrs.css"/>
	<link href="<openmrs:contextPath/><spring:theme code='stylesheet' />" type="text/css" rel="stylesheet"/>
	<openmrs:htmlInclude file="/style.css"/>
	<openmrs:htmlInclude file="/dwr/engine.js"/>
	<c:if test="${empty DO_NOT_INCLUDE_JQUERY}">
		<openmrs:htmlInclude file="/scripts/jquery/jquery.min.js"/>
		<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui.custom.min.js"/>
		<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui-timepicker-addon.js"/>
		<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui-datepicker-i18n.js"/>
		<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui-timepicker-i18n.js"/>
		<link href="<openmrs:contextPath/>/scripts/jquery-ui/css/<spring:theme code='jqueryui.theme.name' />/jquery-ui.custom.css"
		      type="text/css" rel="stylesheet"/>
	</c:if>
	<link rel="shortcut icon" type="image/ico" href="<openmrs:contextPath/><spring:theme code='favicon' />">
	<link rel="icon" type="image/png" href="<openmrs:contextPath/><spring:theme code='favicon.png' />">

	<c:choose>
		<c:when test="${!empty pageTitle}">
			<title>${pageTitle}</title>
		</c:when>
		<c:otherwise>
			<title><openmrs:message code="openmrs.title"/></title>
		</c:otherwise>
	</c:choose>


	<script type="text/javascript">
		<
		c:if test = "${empty DO_NOT_INCLUDE_JQUERY}" >
			var $j = jQuery.noConflict();
		</
		c:if>
		/* variable used in js to know the context path */
		var openmrsContextPath = '${pageContext.request.contextPath}';
		var dwrLoadingMessage = '<openmrs:message code="general.loading" />';
		var jsDateFormat = '<openmrs:datePattern localize="false"/>';
		var jsTimeFormat = '<openmrs:timePattern format="jquery" localize="false"/>';
		var jsLocale = '<%= org.openmrs.api.context.Context.getLocale() %>';

		/* prevents users getting false dwr errors msgs when leaving pages */
		var pageIsExiting = false;
		if (typeof(jQuery) != "undefined")
			jQuery(window).bind('beforeunload', function () {
				pageIsExiting = true;
			});

		var handler = function (msg, ex) {
			if (!pageIsExiting) {
				var div = document.getElementById("openmrs_dwr_error");
				div.style.display = ""; // show the error div
				var msgDiv = document.getElementById("openmrs_dwr_error_msg");
				msgDiv.innerHTML = '<openmrs:message code="error.dwr"/>' + " <b>" + msg + "</b>";
			}

		};
		dwr.engine.setErrorHandler(handler);
		dwr.engine.setWarningHandler(handler);
	</script>

	<openmrs:extensionPoint pointId="org.openmrs.headerMinimalIncludeExt" type="html"
	                        requiredClass="org.openmrs.module.web.extension.HeaderIncludeExt">
		<c:forEach var="file" items="${extension.headerFiles}">
			<openmrs:htmlInclude file="${file}"/>
		</c:forEach>
	</openmrs:extensionPoint>

</head>

<body>
<div id="pageBody">
	<div id="contentMinimal">
		<c:if test="${msg != null}">
			<div id="openmrs_msg"><openmrs:message code="${msg}" text="${msg}" arguments="${msgArgs}"/></div>
		</c:if>
		<c:if test="${err != null}">
			<div id="openmrs_error"><openmrs:message code="${err}" text="${err}" arguments="${errArgs}"/></div>
		</c:if>

		<div id="openmrs_dwr_error" style="display:none" class="error">
			<div id="openmrs_dwr_error_msg"></div>
			<div id="openmrs_dwr_error_close" class="smallMessage">
				<i><openmrs:message code="error.dwr.stacktrace"/></i>
				<a href="#" onclick="this.parentNode.parentNode.style.display='none'"><openmrs:message
						code="error.dwr.hide"/></a>
			</div>
		</div>
