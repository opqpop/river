<%--
  Created by IntelliJ IDEA.
  User: mxia
  Date: 10/8/13
  Time: 10:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <title>LolRiver - League of Legends Video Stream Portal</title>
    <meta name="keywords" content="League of Legends, LoL, video game, stream, twitch, streaming, LoL game, elo">
    <meta name="description"
          content="League of Legends Video Stream Portal - Browse and watch LoL streams based on champion played, streamer, elo, and more">
    <meta name="author" content="Mark Donkey">

    <link rel="stylesheet" type="text/css" href="/static/css/index.css"/>
    <link rel="stylesheet" href="/static/css/jquery/ui-lightness/jquery-ui-1.10.3.custom.css"/>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

    <script>
        $(function () {
            $("#streamers").autocomplete({
                source: '${pageContext.request.contextPath}/autocompleteStreamerList',
            });

            $("#championPlayed").autocomplete({
                source: '${pageContext.request.contextPath}/autocompleteChampionList',
            });

            $("#championFaced").autocomplete({
                source: '${pageContext.request.contextPath}/autocompleteChampionList',
            });
        });
    </script>
</head>

<body>
<a href="/"><img class="logo" src="/static/images/logo.png"></a>

<form method="POST" action="/searchClips">
    <table class="search">
        <tr>
            <td class="randomSkin" rowspan="5"><img class="randomSkin" src=${randomSkinFile}></td>
            <td class="search">Streamer:</td>
            <td class="searchBox">
                <div class="ui-widget">
                    <input id="streamers" tabindex="1" type="text" name="streamerName"
                           value=${fn:escapeXml(param.streamerName)}>
                </div>
            </td>
            <td class="searchRole checkBox" rowspan="5">
                <c:set var="topChecked" value=""/>
                <c:set var="midChecked" value=""/>
                <c:set var="jungChecked" value=""/>
                <c:set var="adcChecked" value=""/>
                <c:set var="suppChecked" value=""/>

                <c:forEach items="${roleCriteria}" var="role">
                <c:choose>
                <c:when test="${role eq '\"TOP\"'}">
                    <c:set var="topChecked" value="checked"/>
                </c:when>
                <c:when test="${role eq '\"MID\"'}">
                    <c:set var="midChecked" value="checked"/>
                </c:when>
                <c:when test="${role eq '\"JUNG\"'}">
                    <c:set var="jungChecked" value="checked"/>
                </c:when>
                <c:when test="${role eq '\"ADC\"'}">
                    <c:set var="adcChecked" value="checked"/>
                </c:when>
                <c:when test="${role eq '\"SUPP\"'}">
                    <c:set var="suppChecked" value="checked"/>
                </c:when>
                </c:choose>
                </c:forEach>

                <input type="checkbox" id="checkboxTop" class="css-checkbox lrg" name="roleCriteria"
                       value="TOP" ${topChecked}>
                <label for="checkboxTop" class="css-label lrg web-two-style">Top</label><br>

                <input type="checkbox" id="checkboxMid" class="css-checkbox lrg" name="roleCriteria"
                       value="MID" ${midChecked}>
                <label for="checkboxMid" class="css-label lrg web-two-style">Mid</label><br>

                <input type="checkbox" id="checkboxJung" class="css-checkbox lrg" name="roleCriteria"
                       value="JUNG" ${jungChecked}>
                <label for="checkboxJung" class="css-label lrg web-two-style">Jung</label><br>

                <input type="checkbox" id="checkboxAdc" class="css-checkbox lrg" name="roleCriteria"
                       value="ADC" ${adcChecked}>
                <label for="checkboxAdc" class="css-label lrg web-two-style">ADC</label><br>

                <input type="checkbox" id="checkboxSupp" class="css-checkbox lrg" name="roleCriteria"
                       value="SUPP" ${suppChecked}>
                <label for="checkboxSupp" class="css-label lrg web-two-style">Supp</label>

            <td class="searchTier checkBox" rowspan="5">
                <c:set var="challengerChecked" value=""/>
                <c:set var="diamondChecked" value=""/>
                <c:set var="platinumChecked" value=""/>
                <c:set var="goldChecked" value=""/>
                <c:set var="silverChecked" value=""/>
                <c:set var="bronzeChecked" value=""/>

                <c:forEach items="${eloCriteria}" var="elo">
                <c:choose>
                <c:when test="${elo eq 'CHALLENGER'}">
                    <c:set var="challengerChecked" value="checked"/>
                </c:when>
                <c:when test="${elo eq 'DIAMOND'}">
                    <c:set var="diamondChecked" value="checked"/>
                </c:when>
                <c:when test="${elo eq 'PLATINUM'}">
                    <c:set var="platinumChecked" value="checked"/>
                </c:when>
                <c:when test="${elo eq 'GOLD'}">
                    <c:set var="goldChecked" value="checked"/>
                </c:when>
                <c:when test="${elo eq 'SILVER'}">
                    <c:set var="silverChecked" value="checked"/>
                </c:when>
                <c:when test="${elo eq 'BRONZE'}">
                    <c:set var="bronzeChecked" value="checked"/>
                </c:when>
                </c:choose>
                </c:forEach>
                <input type="checkbox" id="checkboxChallenger" class="css-checkbox lrg" name="eloCriteria"
                       value="CHALLENGER" ${challengerChecked}>
                <label for="checkboxChallenger" class="css-label lrg web-two-style">Challenger</label><br>

                <input type="checkbox" id="checkboxDiamond" class="css-checkbox lrg" name="eloCriteria"
                       value="DIAMOND" ${diamondChecked}>
                <label for="checkboxDiamond" class="css-label lrg web-two-style">Diamond</label><br>

                <input type="checkbox" id="checkboxPlatnium" class="css-checkbox lrg" name="eloCriteria"
                       value="PLATINUM" ${platinumChecked}>
                <label for="checkboxPlatnium" class="css-label lrg web-two-style">Platinum</label><br>

                <input type="checkbox" id="checkboxGold" class="css-checkbox lrg" name="eloCriteria"
                       value="GOLD" ${goldChecked}>
                <label for="checkboxGold" class="css-label lrg web-two-style">Gold</label><br>

                <input type="checkbox" id="checkboxSilver" class="css-checkbox lrg" name="eloCriteria"
                       value="SILVER" ${silverChecked}>
                <label for="checkboxSilver" class="css-label lrg web-two-style">Silver</label><br>

                <input type="checkbox" id="checkboxBronze" class="css-checkbox lrg" name="eloCriteria"
                       value="BRONZE" ${bronzeChecked}>
                <label for="checkboxBronze" class="css-label lrg web-two-style">Bronze</label>

            <td class="search" rowspan="5">
                <input class="searchButton" type="image"
                       src="/static/images/ui/buttons/button_search.png"
                       alt="Search clips">
            </td>
        </tr>
        <tr>
            <td class="search">Champion Played:</td>
            <td class="searchBox">
                <div class="ui-widget">
                    <input id="championPlayed" tabindex="2" type="text" name="championPlayedString"
                           value=${fn:escapeXml(param.championPlayedString)}>
                </div>
            </td>
        </tr>
        <tr>
            <td class="search">Champion Faced:</td>
            <td class="searchBox">
                <div class="ui-widget">
                    <input id="championFaced" tabindex="2" type="text" name="championFacedString"
                           value=${fn:escapeXml(param.championFacedString)}>
                </div>
            </td>
        </tr>
        <tr>
            <td class="search">Min Length:</td>
            <td class="searchBox">
                <div class="ui-widget">
                    <input id="minLength" tabindex="3" class="clipLength" type="number" name="minLength"
                           value=${fn:escapeXml(param.minLength)}>
                </div>
            </td>
        </tr>
        <tr>
            <td class="search">Max Length:</td>
            <td class="searchBox">
                <div class="ui-widget">
                    <input tabindex="4" class="clipLength" type="number" name="maxLength"
                           value=${fn:escapeXml(param.maxLength)}>
                </div>
            </td>
        </tr>
    </table>
</form>

<br>
<table class="clips">
    <tr>
        <th>Date <img class="sortButtonEnabled" src="/static/images/ui/buttons/button_sortDown.png"></th>
        <th>Streamer <img class="sortButtonDisabled" src="/static/images/ui/buttons/button_sortDown.png"></th>
        <th>Role</th>
        <th colspan="2">Matchup</th>
        <th>Tier</th>
        <th>Length</th>
        <th>Views</th>
        <th>Rating</th>
        <th class="paginationHeader">
            Page<br>
            <c:set var="prevPage1" value="${param.p - 3}"></c:set>
            <c:set var="prevPage2" value="${param.p - 2}"></c:set>
            <c:set var="prevPage3" value="${param.p - 1}"></c:set>
            <c:set var="nextPage1" value="${param.p + 1}"></c:set>
            <c:set var="nextPage2" value="${param.p + 2}"></c:set>
            <c:set var="nextPage3" value="${param.p + 3}"></c:set>
            <c:if test="${param.p gt 1}">
                <a href="?p=${param.p - 1}">&lt;</a>
            </c:if>

            <c:if test="${prevPage1 gt 1}">
                <a href="?p=1">1</a>
            </c:if>

            <c:if test="${prevPage1 gt 2}">
                ...
            </c:if>

            <c:if test="${prevPage1 ge 1}">
                <a class="page" href="?p=${prevPage1}">${prevPage1}</a>
            </c:if>
            <c:if test="${prevPage2 ge 1}">
                <a class="page" href="?p=${prevPage2}">${prevPage2}</a>
            </c:if>
            <c:if test="${prevPage3 ge 1}">
                <a class="page" href="?p=${prevPage3}">${prevPage3}</a>
            </c:if>

            <a class="page" id="curPage" href="?p=${param.p}" class="curentPage">${param.p}</a>

            <c:if test="${nextPage1 le numClipPages}">
                <a class="page" href="?p=${nextPage1}">${nextPage1}</a>
            </c:if>
            <c:if test="${nextPage2 le numClipPages}">
                <a class="page" href="?p=${nextPage2}">${nextPage2}</a>
            </c:if>
            <c:if test="${nextPage3 le numClipPages}">
                <a class="page" href="?p=${nextPage3}">${nextPage3}</a>
            </c:if>

            <c:if test="${nextPage3 lt numClipPages}">
                ...
                <a class="page" href="?p=${numClipPages}">${numClipPages}</a>
            </c:if>

            <c:if test="${param.p lt numClipPages}">
                <a href="?p=${param.p + 1}">&gt;</a>
            </c:if></th>
    </tr>

    <c:forEach items="${clips}" var="clip">
        <tr class="clips">
            <td><fmt:formatDate type="date" value="${clip.startTime}"/></td>
            <td>
                <form method="POST" id="streamerForm" action="/searchClips">
                    <input type='hidden' name='streamerName' value="${clip.streamerName}">
                    <a href="javascript: submitForm('streamerForm')">
                            ${clip.streamerName}</a>
                </form>
            </td>
            <td>${fn:toLowerCase(clip.rolePlayed.name)}</td>
            <td colspan="2">
                <img class="avatarSelf"
                     src="static/images/avatars/avatar_${fn:toLowerCase(clip.championPlayed.name)}.png">

                <c:set var="lanePartnerChampionName" value="${fn:toLowerCase(clip.lanePartnerChampion.name)}"/>
                <c:if test="${empty lanePartnerChampionName}">
                    <c:set var="lanePartnerChampionName" value="blank"></c:set>
                </c:if>
                <img class="avatar" src="static/images/avatars/avatar_${lanePartnerChampionName}.png">

                VS

                <img class="avatarEnemy"
                     src="static/images/avatars/avatar_${fn:toLowerCase(clip.championFaced.name)}.png">

                <c:set var="enemyLanePartnerChampionName"
                       value="${fn:toLowerCase(clip.enemyLanePartnerChampion.name)}"/>
                <c:if test="${empty enemyLanePartnerChampionName}">
                    <c:set var="enemyLanePartnerChampionName" value="blank"></c:set>
                </c:if>
                <img class="avatar"
                     src="static/images/avatars/avatar_${enemyLanePartnerChampionName}.png">
            </td>
            <td><img class="badgeChallenger"
                     src="static/images/badge/badge3_${fn:toLowerCase(clip.generalElo)}.png"></td>
            <td><fmt:formatNumber value="${clip.length / 60}" maxFractionDigits="0"/> min</td>
            <td><fmt:formatNumber value="${clip.views}"/></td>
            <td>9.5</td>
            <td><a href="${clip.url}"><img class="watchButton"
                                           src="static/images/ui/buttons/button_watchVideo.png"/></a></td>
        </tr>
    </c:forEach>

</table>
</form>
</body>

</html>