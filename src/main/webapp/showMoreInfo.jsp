<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/base/include.jsp" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<SCRIPT src="${JS_PATH}/json2.js" type=text/javascript></SCRIPT>
<SCRIPT src="${JS_PATH}/showPag.js" type=text/javascript></SCRIPT>
<style type="text/css">
    .maintab td {
        text-align: center
    }
</style>
<script type="text/javascript" src="admin/fckeditor/fckeditor.js"></script>

<head>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8" />
    <title>标书信息查看</title>
</head>

<body>
<div class="mainbody">
    <table class="maintab" width="100%">
        <tr>
            <th width="30%">报价状态</th>
            <th width="50%">可用操作</th>
            <th width="20%">不报价原因说明</th></tr>
        <c:forEach var="ginfo" items="${resourceGinfoList}" varStatus="status">
            <input type="hidden" id="ziv_hidden_ginfoNumber" value="${ginfo.ginfoNumber}" />
            <input type="hidden" id="ziv_hidden_glistTempbatch" value="${ginfo.glistTempbatch}" />
            <tr id="zivMainTr">
                <td width="30%" style="text-align: center;">
                    <c:if test="${msgMap1[ginfo.glistTempbatch] eq 0 }">未报价</c:if>
                    <c:if test="${msgMap1[ginfo.glistTempbatch] eq 1 }">已报价</c:if></td>
                <td width="50%" style="text-align: center;">
                    <c:if test="${ginfo.dataBillstate eq 5 and ginfo.pricesetDt eq '0' and ginfo.scontractEtype eq '2'}">
                        <a href="${ctx }/enterTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报名</a></c:if>
                    <!--采购标书第一轮 报价中 且未曾报价 -->
                    <c:if test="${ginfo.ginfoType eq '1' and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 0 }">
                        <c:if test="${ginfo.ginfoLnum eq 1 or ginfo.ginfoLnum eq 0}">
                            <!--苏豪前台标记已缴保证金费用 -->
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq '1' }">
                                <a href="${ctx }/buyTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                            <!--苏豪未标记已缴保证金 并且也该供应商也没有保证金 -->
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq '0'}">
                                <c:if test="${ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/buyTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                <c:if test="${ginfo.ginfoErate ne 0}">
                                    <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 ) or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney}">
                                        <a href="${ctx }/buyTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <c:if test="${ginfo.ginfoLnum ne 1 and ginfo.ginfoLnum ne 0}">
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq '1' }">
                                <a href="${ctx }/tenderQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq '0' }">
                                <c:if test="${ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/tenderQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a>
                                </c:if>
                                <c:if test="${ginfo.ginfoErate ne 0}">
                                    <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 ) or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney}">
                                        <a href="${ctx }/tenderQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <a id="title" href="javascript:;" onClick="dlg =new Dialog({type:'url',value:('cqAfficheAction!getCqAffiche.htm?glistTempbatch=${ginfo.glistTempbatch}')},{id:'content-display',draggable:false,title:'澄清公告',subtitle:'',height:540});dlg.show();">澄清公告</a>
                    </c:if>
                    <!--采购标书任意轮次 报价中 且已经报价 -->
                    <c:if test="${ginfo.ginfoType eq '1' and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/tenderQuotationNextAction.htm?glistTempbatch=${ginfo.glistTempbatch}">重新报价</a></c:if>
                    <!--采购标书 已开标或购销待核价 且有报价 -->
                    <c:if test="${ginfo.ginfoType eq '1' and (ginfo.dataBillstate eq 8 or ginfo.dataBillstate eq 28) and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/cgckTender2Action.htm?ginfoBillno=${ginfo.ginfoBillno}&ginfoLnum=${ginfo.ginfoLnum}">查看报价</a></c:if>
                    <!--采购标书 标书结束 可以查看中标情况 -->
                    <c:if test="${ginfo.ginfoType eq '1' and ginfo.dataBillstate eq 10 }">
                        <a href="${ctx }/cgzbTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}">中标情况</a></c:if>

                    <!--公开招标 （不一定准确） -->
                    <c:if test="${ginfo.ginfoType eq '0' and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 0 }">
                        <c:if test="${ginfo.ginfoLnum eq 1 or ginfo.ginfoLnum eq 0}">
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 1 }">
                                <a href="${ctx }/buyTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 0 or priceSetMoneyFlagMap[ginfo.glistTempbatch] == null}">
                                <c:if test="${queryReDeposit == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${queryReDeposit == null and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/buyTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                <c:if test="${queryReDeposit != null and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/buyTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                <c:if test="${queryReDeposit != null and depositmap.size eq 0 and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap.size eq 0 and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/buyTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                <c:if test="${depositmap.size ne 0 and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap[ginfo.memberCode] != null}">
                                    <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney
                          or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney
                          or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney
                          or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 )}">
                                        <a href="${ctx }/buyTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <c:if test="${ginfo.ginfoLnum ne 1 and ginfo.ginfoLnum ne 0}">
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 1 }">
                                <a href="${ctx }/tenderQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 0 or priceSetMoneyFlagMap[ginfo.glistTempbatch] == null}">
                                <c:if test="${queryReDeposit == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${queryReDeposit == null and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/tenderQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit != null and depositmap[ginfo.memberCode] == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/tenderQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${queryReDeposit != null and depositmap.size eq 0 and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap.size eq 0 and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/tenderQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${depositmap.size ne 0 and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap[ginfo.memberCode] != null}">
                                    <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney
                          or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney
                          or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney
                          or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 )}">
                                        <a href="${ctx }/tenderQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <a id="title" href="javascript:;" onClick="dlg =new Dialog({type:'url',value:('cqAfficheAction!getCqAffiche.htm?glistTempbatch=${ginfo.glistTempbatch}')},{id:'content-display',draggable:false,title:'澄清公告',subtitle:'',height:540});dlg.show();">澄清公告</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '0' and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/tenderQuotationNextAction.htm?glistTempbatch=${ginfo.glistTempbatch}">重新报价</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '0' and (ginfo.dataBillstate eq 8 or ginfo.dataBillstate eq 28) and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/cgckTender2Action.htm?ginfoBillno=${ginfo.ginfoBillno}&ginfoLnum=${ginfo.ginfoLnum}">查看报价</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '0' and ginfo.dataBillstate eq 10 }">
                        <a href="${ctx }/cgzbTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}">中标情况</a></c:if>


                    <!--项目招标 -->
                    <c:if test="${ginfo.ginfoType eq '3' and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 0 }">
                        <c:if test="${ginfo.ginfoLnum eq 1 or ginfo.ginfoLnum eq 0}">
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 1 }">
                                <a href="${ctx }/xmTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 0 or priceSetMoneyFlagMap[ginfo.glistTempbatch] == null}">
                                <c:if test="${queryReDeposit == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/xmTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit != null and depositmap[ginfo.memberCode] == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/xmTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                <c:if test="${queryReDeposit != null and depositmap.size eq 0 and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap.size eq 0 and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/xmTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                <c:if test="${depositmap.size ne 0 and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap[ginfo.memberCode] != null}">
                                    <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney
                          or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney
                          or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney
                          or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 )}">
                                        <a href="${ctx }/xmTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <c:if test="${ginfo.ginfoLnum ne 1 and ginfo.ginfoLnum ne 0}">
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 1 }">
                                <a href="${ctx }/xmQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 0 or priceSetMoneyFlagMap[ginfo.glistTempbatch] == null}">
                                <c:if test="${queryReDeposit == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/xmQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit != null and depositmap[ginfo.memberCode] == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/xmQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${queryReDeposit != null and depositmap.size eq 0 and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap.size eq 0 and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/xmQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${depositmap.size ne 0 and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap[ginfo.memberCode] != null}">
                                    <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney
                          or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney
                          or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney
                          or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 )}">
                                        <a href="${ctx }/xmQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <a id="title" href="javascript:;" onClick="dlg =new Dialog({type:'url',value:('cqAfficheAction!getCqAffiche.htm?glistTempbatch=${ginfo.glistTempbatch}')},{id:'content-display',draggable:false,title:'澄清公告',subtitle:'',height:540});dlg.show();">澄清公告</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '3' and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/xmQuotationNextAction.htm?glistTempbatch=${ginfo.glistTempbatch}">重新报价</a>
                        <a id="title" href="javascript:;" onClick="dlg =new Dialog({type:'url',value:('cqAfficheAction!getCqAffiche.htm?glistTempbatch=${ginfo.glistTempbatch}')},{id:'content-display',draggable:false,title:'澄清公告',subtitle:'',height:540});dlg.show();">澄清公告</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '3' and (ginfo.dataBillstate eq 8 or ginfo.dataBillstate eq 28) and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/xmckTender2Action.htm?ginfoBillno=${ginfo.ginfoBillno}&ginfoLnum=${ginfo.ginfoLnum}">查看项目报价</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '3' and ginfo.dataBillstate eq 10 }">
                        <a href="${ctx }/xmzbTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}">中标情况</a></c:if>


                    <!--竞价招标 （不一定准确）-->
                    <c:if test="${ginfo.ginfoType eq '2' and ( ginfo.ginfoLnum eq 1 or ginfo.ginfoLnum eq 0 )and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 0 }">
                        <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 1 }">
                            <a href="${ctx }/jjTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                        <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 0 or priceSetMoneyFlagMap[ginfo.glistTempbatch] == null}">
                            <c:if test="${queryReDeposit == null and ginfo.ginfoErate ne 0}">
                                <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                            <c:if test="${(queryReDeposit == null ) and ginfo.ginfoErate eq 0}">
                                <a href="${ctx }/jjTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                            <c:if test="${(queryReDeposit != null and depositmap[ginfo.memberCode] == null) and ginfo.ginfoErate eq 0}">
                                <a href="${ctx }/jjTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                            <c:if test="${queryReDeposit != null and depositmap.size eq 0 and ginfo.ginfoErate ne 0}">
                                <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                            <c:if test="${depositmap.size eq 0 and ginfo.ginfoErate eq 0}">
                                <a href="${ctx }/jjTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                            <c:if test="${depositmap.size ne 0 and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate ne 0}">
                                <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                            <c:if test="${depositmap[ginfo.memberCode] != null}">
                                <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 )}">
                                    <a href="${ctx }/jjTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                            </c:if>
                        </c:if>
                        <a id="title" href="javascript:;" onClick="dlg =new Dialog({type:'url',value:('cqAfficheAction!getCqAffiche.htm?glistTempbatch=${ginfo.glistTempbatch}')},{id:'content-display',draggable:false,title:'澄清公告',subtitle:'',height:540});dlg.show();">澄清公告</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '2' and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/jjQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}">重新报价</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '2' and (ginfo.dataBillstate eq 8 or ginfo.dataBillstate eq 28) and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/cgckTender2Action.htm?ginfoBillno=${ginfo.ginfoBillno}&ginfoLnum=${ginfo.ginfoLnum}">查看报价</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '2' and ginfo.dataBillstate eq 10 }">
                        <a href="${ctx }/cgzbTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}">中标情况</a></c:if>
                    <!--销售招标 -->
                    <c:if test="${ginfo.ginfoType eq '4' and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 0 }">
                        <c:if test="${ginfo.ginfoLnum eq 1 or ginfo.ginfoLnum eq 0}">
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 1 }">
                                <a href="${ctx }/buyFcpConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 0 or priceSetMoneyFlagMap[ginfo.glistTempbatch] == null}">
                                <c:if test="${queryReDeposit == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/buyFcpConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit != null and depositmap[ginfo.memberCode] == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/buyFcpConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                <c:if test="${queryReDeposit != null and depositmap.size eq 0 and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap.size eq 0 and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/buyFcpConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                <c:if test="${depositmap.size ne 0 and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap[ginfo.memberCode] != null}">
                                    <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 )}">
                                        <a href="${ctx }/buyFcpConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}">我要报价</a></c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <c:if test="${ginfo.ginfoLnum ne 1 and ginfo.ginfoLnum ne 0}">
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 1 }">
                                <a href="${ctx }/fcpQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 0 or priceSetMoneyFlagMap[ginfo.glistTempbatch] == null}">
                                <c:if test="${queryReDeposit == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/fcpQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit != null and depositmap[ginfo.memberCode] == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/fcpQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${queryReDeposit != null and depositmap.size eq 0 and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap.size eq 0 and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/fcpQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${depositmap.size ne 0 and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap[ginfo.memberCode] != null}">
                                    <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 )}">
                                        <a href="${ctx }/fcpQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <a id="title" href="javascript:;" onClick="dlg =new Dialog({type:'url',value:('cqAfficheAction!getCqAffiche.htm?glistTempbatch=${ginfo.glistTempbatch}')},{id:'content-display',draggable:false,title:'澄清公告',subtitle:'',height:540});dlg.show();">澄清公告</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '4' and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/fcpQuotationNextAction.htm?glistTempbatch=${ginfo.glistTempbatch}">重新报价</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '4' and (ginfo.dataBillstate eq 8 or ginfo.dataBillstate eq 28) and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/cgckFcpAction.htm?ginfoBillno=${ginfo.ginfoBillno}&ginfoLnum=${ginfo.ginfoLnum}">查看报价</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '4' and ginfo.dataBillstate eq 10 }">
                        <a href="${ctx }/xszbTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}">中标情况</a></c:if>

                    <!--不知什么标书 -->
                    <c:if test="${ginfo.ginfoType eq '10' and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 0 }">
                        <c:if test="${ginfo.ginfoLnum eq 1 or ginfo.ginfoLnum eq 0}">
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 1 }">
                                <a href="${ctx }/gkjjmTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 0 or priceSetMoneyFlagMap[ginfo.glistTempbatch] == null}">
                                <c:if test="${queryReDeposit == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/gkjjmTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit != null and depositmap[ginfo.memberCode] == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/gkjjmTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${queryReDeposit != null and depositmap.size eq 0 and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap.size eq 0 and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/gkjjmTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${depositmap.size ne 0 and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap[ginfo.memberCode] != null}">
                                    <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 )}">
                                        <a href="${ctx }/gkjjmTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <a id="title" href="javascript:;" onClick="dlg =new Dialog({type:'url',value:('cqAfficheAction!getCqAffiche.htm?glistTempbatch=${ginfo.glistTempbatch}')},{id:'content-display',draggable:false,title:'澄清公告',subtitle:'',height:540});dlg.show();">澄清公告</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '10' and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/gkjjmQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}">重新报价</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '10' and (ginfo.dataBillstate eq 8 or ginfo.dataBillstate eq 28) and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/cgckTender2Action.htm?ginfoBillno=${ginfo.ginfoBillno}&ginfoLnum=${ginfo.ginfoLnum}">查看报价</a></c:if>
                    <c:if test="${ginfo.ginfoType eq '10' and ginfo.dataBillstate eq 10 }">
                        <a href="${ctx }/cgzbTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}">中标情况</a></c:if>

                    <!--国贸设备招标 -->
                    <c:if test="${(ginfo.ginfoType eq '5'  or ginfo.ginfoType eq '8' or ginfo.ginfoType eq '9' ) and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 0 }">
                        <c:if test="${ginfo.ginfoLnum eq 1 or ginfo.ginfoLnum eq 0}">
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 1 }">
                                <a href="${ctx }/gmTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}" target="_blank">我要报价</a></c:if>
                            <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 0 or priceSetMoneyFlagMap[ginfo.glistTempbatch] == null}">
                                <c:if test="${queryReDeposit == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/gmTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}" target="_blank">我要报价</a></c:if>
                                <c:if test="${(queryReDeposit != null and depositmap[ginfo.memberCode] == null) and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/gmTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}" target="_blank">我要报价</a></c:if>
                                <c:if test="${queryReDeposit != null and depositmap.size eq 0 and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap.size eq 0 and ginfo.ginfoErate eq 0}">
                                    <a href="${ctx }/gmTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}" target="_blank">我要报价</a></c:if>
                                <c:if test="${depositmap.size ne 0 and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate ne 0}">
                                    <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                <c:if test="${depositmap[ginfo.memberCode] != null}">
                                    <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 )}">
                                        <a href="${ctx }/gmTenderConfirmAction.htm?glistTempbatch=${ginfo.glistTempbatch}" target="_blank">我要报价</a></c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <c:if test="${ginfo.ginfoType eq '5'}">
                            <c:if test="${ginfo.ginfoLnum ne 1 and ginfo.ginfoLnum ne 0}">
                                <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 1 }">
                                    <a href="${ctx }/gmsQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 0 or priceSetMoneyFlagMap[ginfo.glistTempbatch] == null}">
                                    <c:if test="${queryReDeposit == null and ginfo.ginfoErate ne 0}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${(queryReDeposit == null) and ginfo.ginfoErate eq 0}">
                                        <a href="${ctx }/gmsQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                    <c:if test="${(queryReDeposit != null and depositmap[ginfo.memberCode] == null) and ginfo.ginfoErate eq 0}">
                                        <a href="${ctx }/gmsQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                    <c:if test="${depositmap.size eq 0 and ginfo.ginfoErate ne 0}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${queryReDeposit != null and depositmap.size eq 0 and ginfo.ginfoErate eq 0}">
                                        <a href="${ctx }/gmsQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                    <c:if test="${depositmap.size ne 0 and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate ne 0}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${depositmap[ginfo.memberCode] != null}">
                                        <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney
                            or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                            <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                        <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney
                            or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney
                            or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 )}">
                                            <a href="${ctx }/gmsQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                    </c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <c:if test="${ginfo.ginfoType ne '5'}">
                            <c:if test="${ginfo.ginfoLnum ne 1 and ginfo.ginfoLnum ne 0}">
                                <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 1 }">
                                    <a href="${ctx }/gmQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                <c:if test="${priceSetMoneyFlagMap[ginfo.glistTempbatch] eq 0 or priceSetMoneyFlagMap[ginfo.glistTempbatch] == null}">
                                    <c:if test="${queryReDeposit == null and ginfo.ginfoErate ne 0}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${(queryReDeposit == null) and ginfo.ginfoErate eq 0}">
                                        <a href="${ctx }/gmQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                    <c:if test="${(queryReDeposit != null and depositmap[ginfo.memberCode] == null) and ginfo.ginfoErate eq 0}">
                                        <a href="${ctx }/gmQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                    <c:if test="${queryReDeposit != null and depositmap.size eq 0 and ginfo.ginfoErate ne 0}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${depositmap.size eq 0 and ginfo.ginfoErate eq 0}">
                                        <a href="${ctx }/gmQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                    <c:if test="${depositmap.size ne 0 and depositmap[ginfo.memberCode] == null and ginfo.ginfoErate ne 0}">
                                        <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                    <c:if test="${depositmap[ginfo.memberCode] != null}">
                                        <c:if test="${ginfo.ginfoErate gt depositmap[ginfo.memberCode].depositMoney
                            or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate gt 0 )}">
                                            <a href="javascript:;" onclick="goBack();">我要报价</a></c:if>
                                        <c:if test="${ginfo.ginfoErate lt depositmap[ginfo.memberCode].depositMoney
                            or ginfo.ginfoErate eq depositmap[ginfo.memberCode].depositMoney
                            or (depositmap[ginfo.memberCode].depositMoney==null and ginfo.ginfoErate eq 0 )}">
                                            <a href="${ctx }/gmQuotationAction.htm?glistTempbatch=${ginfo.glistTempbatch}&saveIp=1">我要报价</a></c:if>
                                    </c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <a id="title" href="javascript:;" onClick="dlg =new Dialog({type:'url',value:('cqAfficheAction!getCqAffiche.htm?glistTempbatch=${ginfo.glistTempbatch}')},{id:'content-display',draggable:false,title:'澄清公告',subtitle:'',height:540});dlg.show();">澄清公告</a></c:if>
                    <c:if test="${(ginfo.ginfoType eq '5'  or ginfo.ginfoType eq '8' or ginfo.ginfoType eq '9' ) and ginfo.dataBillstate eq 7 and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/gmsQuotationNextAction.htm?glistTempbatch=${ginfo.glistTempbatch}" target="_blank">重新报价</a></c:if>
                    <c:if test="${(ginfo.ginfoType eq '5'  or ginfo.ginfoType eq '8' or ginfo.ginfoType eq '9' ) and (ginfo.dataBillstate eq 8 or ginfo.dataBillstate eq 28) and msgMap1[ginfo.glistTempbatch] eq 1 }">
                        <a href="${ctx }/cgckTender2Action.htm?ginfoBillno=${ginfo.ginfoBillno}&ginfoLnum=${ginfo.ginfoLnum}">查看报价</a></c:if>
                    <c:if test="${(ginfo.ginfoType eq '5'  or ginfo.ginfoType eq '8' or ginfo.ginfoType eq '9' ) and ginfo.dataBillstate eq 10 }">
                        <a href="${ctx }/cgzbTenderAction.htm?glistTempbatch=${ginfo.glistTempbatch}">中标情况</a></c:if>
                </td>
                <td width="20%">
                    <c:if test="${ginfo.ginfoLnum eq '1' && ginfo.dataBillstate eq '7'}">
                        <a href="${ctx }/buyFcpConfirmAction!saveRemark.htm?glistTempbatch=${ginfo.glistTempbatch}">不报价原因说明</a></c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
    <div class="clearfix"></div>
    <div class="atr fr width_cancel" style="float:right; margin-left:250px;">
            <span class="subt">
              <input type="button" value="返 回" name="Submit" onclick="dlg.close()" /></span>
    </div>
</div>
</body>

</html>
<script>function checkRemark() {
    var tempTempbatch = $("#ziv_hidden_glistTempbatch").val();
    var tempGinfoNumber = $("#ziv_hidden_ginfoNumber").val();

    $.ajax({
        url: "buyFcpConfirmAction!checkRemarkInfo.htm",
        data: {
            "glistTempbatch": tempTempbatch,
            "ginfoNumber": tempGinfoNumber
        },
        async: false,
        type: "POST",
        dataType: "text",
        success: function(data) {
            if ("have" == data) {
                $("#zivMainTr").find("td").eq(1).html("如确定要报价，请将不报价理由清空后再进行报价。");
            }
        }
    });

}

checkRemark();</script>