package com.soft.exchange.biz.purchase.action;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.soft.bc.balance.deposit.vo.BalanceDepositListVo;
import com.soft.bc.balance.deposit.vo.BalanceDepositViewVo;
import com.soft.bc.balance.deposit.vo.DepositListQueryBean;
import com.soft.bc.balance.deposit.vo.DepositQueryBean;
import com.soft.bc.balance.deposit.vo.QueryReDeposit;
import com.soft.bc.balance.deposit.vo.QueryReDepositList;
import com.soft.bc.permission.interceptor.vo.UserSession;
import com.soft.bc.resource.attachment.vo.AttachmentViewVo;
import com.soft.bc.resource.ginfo.vo.QueryBean;
import com.soft.bc.resource.ginfo.vo.ResourceGinfoRe;
import com.soft.bc.resource.ginfo.vo.ResourceGinfoViewVo;
import com.soft.bc.resource.ginfolist.vo.GinfoListViewVo;
import com.soft.bc.resource.gprice.vo.MgpriceQueryBean;
import com.soft.bc.resource.gprice.vo.ResourceGpriceRe;
import com.soft.bc.resource.gprice.vo.ResourceGpriceViewVo;
import com.soft.bc.resource.gprice.vo.ResourceGpriceVo;
import com.soft.bc.resource.gprice.vo.ResourceMemgpriceRe;
import com.soft.bc.resource.gprice.vo.ResourceMemgpriceViewVo;
import com.soft.bc.resource.gprice.vo.ResourceMgpriceViewVo;
import com.soft.bc.resource.gprice.vo.ResourceMgpriceVo;
import com.soft.bc.resource.memberRelation.vo.MemberRelationVo;
import com.soft.bc.resource.resource.vo.GoodsQueryVo;
import com.soft.bc.resource.resource.vo.ListQueryVo;
import com.soft.bc.resource.resource.vo.QueryResourceGlistVo;
import com.soft.bc.resource.resource.vo.QueryResourceGoodsVo;
import com.soft.bc.resource.resource.vo.ResourceGlistViewVo;
import com.soft.bc.resource.resource.vo.ResourceGoodsViewVo;
import com.soft.plat.common.action.BaseAction;
import com.soft.plat.common.exception.BusinessException;
import com.soft.plat.common.validate.Validator;
import com.soft.plat.system.Session;
import com.soft.sb.util.BeanUtils;
import com.soft.sb.util.StringUtil;

public class CgckTenderAction extends BaseAction {

	private static final long serialVersionUID = -8933235605886407136L;
	private Map<String, ResourceGoodsViewVo> resourceGoodsViewVoMap = new HashMap<String, ResourceGoodsViewVo>();
	private List<PriceMonitoringViewVo> priceMonitoringViewVos = new ArrayList<PriceMonitoringViewVo>();
	private List<TenderQuotationViewVo> tenderQuotationViewVos = new ArrayList<TenderQuotationViewVo>();
	private List<ResourceGlistViewVo> resourceGlistViewVos = new ArrayList<ResourceGlistViewVo>();
	private List<ResourceGpriceVo> resourceGpriceVoList = new ArrayList<ResourceGpriceVo>();
	private List<GinfoListViewVo> resourceGinfoListViewVos = new ArrayList<GinfoListViewVo>();
	private ResourceGinfoViewVo resourceGinfoViewVo = new ResourceGinfoViewVo();
	private ResourceGinfoViewVo resourceGinfoViewVoOld = new ResourceGinfoViewVo();
	private Map<String, Object> ginfoListMap = new HashMap<String, Object>();
	private Map<String, ResourceMemgpriceViewVo> memgPriceMap;
	private Map<String, ResourceGoodsViewVo> resourceGoodsMap;
	private Map<String, ResourceGpriceViewVo> gPriceMap;
	private Map<String, ResourceGpriceViewVo> gPriceMapNew;
	private Map<String, Object> params;
	private String ginfoNumber;
	private List<AttachmentViewVo> attachmentVosByJS = new ArrayList<AttachmentViewVo>();
	private List<AttachmentViewVo> attachmentVosBySW = new ArrayList<AttachmentViewVo>();
	private List<AttachmentViewVo> attachmentVosByQT = new ArrayList<AttachmentViewVo>();
	private ResourceMgpriceViewVo resourceMgpriceViewVos;
	private QueryBean queryBeanVo = new QueryBean();
	private String excelFile;
	private String excelFileFileName;
	private ResourceMgpriceVo resourceMgpriceVo;
	private String glistTempbatch;
	private String ginfoBillno;
	private Long ginfoLnum;
	
	private QueryReDeposit queryReDeposit;
	private String glistTempbatch_states;

	private HashMap<String, BalanceDepositViewVo> depositmap = new HashMap<String, BalanceDepositViewVo>();
	private Map<String, Object> msgMap1;
	private List<GinfoListViewVo>  resourceGinfoListList  =  new ArrayList<GinfoListViewVo>();
;
	private Map<String, String> priceSetMoneyFlagMap =new HashMap<String, String>();

	List<ResourceGinfoViewVo> resourceGinfoList;
	
	public QueryBean getQueryBeanVo() {
		return queryBeanVo;
	}

	public void setQueryBeanVo(QueryBean queryBeanVo) {
		this.queryBeanVo = queryBeanVo;
	}

	public String getGlistTempbatch() {
		return glistTempbatch;
	}

	public void setGlistTempbatch(String glistTempbatch) {
		this.glistTempbatch = glistTempbatch;
	}

	public Long getGinfoLnum() {
		return ginfoLnum;
	}

	public void setGinfoLnum(Long ginfoLnum) {
		this.ginfoLnum = ginfoLnum;
	}

	public String getGinfoBillno() {
		return ginfoBillno;
	}

	public void setGinfoBillno(String ginfoBillno) {
		this.ginfoBillno = ginfoBillno;
	}

	/**
	 * priceMonitoringViewVos的获取.
	 * @return List<PriceMonitoringViewVo>
	 */
	public List<PriceMonitoringViewVo> getPriceMonitoringViewVos() {
		return priceMonitoringViewVos;
	}

	/**
	 * 设定priceMonitoringViewVos的值.
	 * @param List<PriceMonitoringViewVo>
	 */
	public void setPriceMonitoringViewVos(
			List<PriceMonitoringViewVo> priceMonitoringViewVos) {
		this.priceMonitoringViewVos = priceMonitoringViewVos;
	}

	/**
	 * resourceGinfoViewVo的获取.
	 * @return ResourceGinfoViewVo
	 */
	public ResourceGinfoViewVo getResourceGinfoViewVo() {
		return resourceGinfoViewVo;
	}

	/**
	 * 设定resourceGinfoViewVo的值.
	 * @param ResourceGinfoViewVo
	 */
	public void setResourceGinfoViewVo(ResourceGinfoViewVo resourceGinfoViewVo) {
		this.resourceGinfoViewVo = resourceGinfoViewVo;
	}

	/**
	 * resourceGinfoListViewVos的获取.
	 * @return List<GinfoListViewVo>
	 */
	public List<GinfoListViewVo> getResourceGinfoListViewVos() {
		return resourceGinfoListViewVos;
	}

	/**
	 * 设定resourceGinfoListViewVos的值.
	 * @param List<GinfoListViewVo>
	 */
	public void setResourceGinfoListViewVos(
			List<GinfoListViewVo> resourceGinfoListViewVos) {
		this.resourceGinfoListViewVos = resourceGinfoListViewVos;
	}

	/**
	 * ginfoListMap的获取.
	 * @return Map<String,Object>
	 */
	public Map<String, Object> getGinfoListMap() {
		return ginfoListMap;
	}

	/**
	 * 设定ginfoListMap的值.
	 * @param Map<String,Object>
	 */
	public void setGinfoListMap(Map<String, Object> ginfoListMap) {
		this.ginfoListMap = ginfoListMap;
	}
	
	/**
	 * ginfoNumber的获取.
	 * @return String
	 */
	public String getGinfoNumber() {
		return ginfoNumber;
	}

	/**
	 * 设定ginfoNumber的值.
	 * @param String
	 */
	public void setGinfoNumber(String ginfoNumber) {
		this.ginfoNumber = ginfoNumber;
	}



	/**
	 * @return the tenderQuotationViewVos
	 */
	public List<TenderQuotationViewVo> getTenderQuotationViewVos() {
		return tenderQuotationViewVos;
	}

	/**
	 * @param tenderQuotationViewVos the tenderQuotationViewVos to set
	 */
	public void setTenderQuotationViewVos(
			List<TenderQuotationViewVo> tenderQuotationViewVos) {
		this.tenderQuotationViewVos = tenderQuotationViewVos;
	}

	@Override
	public void inputValidate(Validator validator) {
		// TODO Auto-generated method stub
		
	}
	
	
	public List<AttachmentViewVo> getAttachmentVosByJS() {
		return attachmentVosByJS;
	}

	public void setAttachmentVosByJS(List<AttachmentViewVo> attachmentVosByJS) {
		this.attachmentVosByJS = attachmentVosByJS;
	}

	public List<AttachmentViewVo> getAttachmentVosBySW() {
		return attachmentVosBySW;
	}

	public void setAttachmentVosBySW(List<AttachmentViewVo> attachmentVosBySW) {
		this.attachmentVosBySW = attachmentVosBySW;
	}

	public List<AttachmentViewVo> getAttachmentVosByQT() {
		return attachmentVosByQT;
	}

	public void setAttachmentVosByQT(List<AttachmentViewVo> attachmentVosByQT) {
		this.attachmentVosByQT = attachmentVosByQT;
	}

	
	
	/**
	 * @return the resourceGlistViewVos
	 */
	public List<ResourceGlistViewVo> getResourceGlistViewVos() {
		return resourceGlistViewVos;
	}

	/**
	 * @param resourceGlistViewVos the resourceGlistViewVos to set
	 */
	public void setResourceGlistViewVos(
			List<ResourceGlistViewVo> resourceGlistViewVos) {
		this.resourceGlistViewVos = resourceGlistViewVos;
	}

	/**
	 * @return the resourceGinfoViewVoOld
	 */
	public ResourceGinfoViewVo getResourceGinfoViewVoOld() {
		return resourceGinfoViewVoOld;
	}

	/**
	 * @param resourceGinfoViewVoOld the resourceGinfoViewVoOld to set
	 */
	public void setResourceGinfoViewVoOld(ResourceGinfoViewVo resourceGinfoViewVoOld) {
		this.resourceGinfoViewVoOld = resourceGinfoViewVoOld;
	}

	/**
	 * @return the memgPriceMap
	 */
	public Map<String, ResourceMemgpriceViewVo> getMemgPriceMap() {
		return memgPriceMap;
	}

	/**
	 * @param memgPriceMap the memgPriceMap to set
	 */
	public void setMemgPriceMap(Map<String, ResourceMemgpriceViewVo> memgPriceMap) {
		this.memgPriceMap = memgPriceMap;
	}

	/**
	 * @return the resourceGoodsMap
	 */
	public Map<String, ResourceGoodsViewVo> getResourceGoodsMap() {
		return resourceGoodsMap;
	}

	/**
	 * @param resourceGoodsMap the resourceGoodsMap to set
	 */
	public void setResourceGoodsMap(
			Map<String, ResourceGoodsViewVo> resourceGoodsMap) {
		this.resourceGoodsMap = resourceGoodsMap;
	}

	/**
	 * @return the gPriceMap
	 */
	public Map<String, ResourceGpriceViewVo> getgPriceMap() {
		return gPriceMap;
	}

	/**
	 * @param gPriceMap the gPriceMap to set
	 */
	public void setgPriceMap(Map<String, ResourceGpriceViewVo> gPriceMap) {
		this.gPriceMap = gPriceMap;
	}

	/**
	 * @return the params
	 */
	public Map<String, Object> getParams() {
		return params;
	}

	/**
	 * @param params the params to set
	 */
	public void setParams(Map<String, Object> params) {
		this.params = params;
	}

	/**
	 * @return the excelFile
	 */
	public String getExcelFile() {
		return excelFile;
	}

	/**
	 * @param excelFile the excelFile to set
	 */
	public void setExcelFile(String excelFile) {
		this.excelFile = excelFile;
	}

	/**
	 * @return the excelFileFileName
	 */
	public String getExcelFileFileName() {
		return excelFileFileName;
	}

	/**
	 * @param excelFileFileName the excelFileFileName to set
	 */
	public void setExcelFileFileName(String excelFileFileName) {
		this.excelFileFileName = excelFileFileName;
	}

	public Map<String, ResourceGoodsViewVo> getResourceGoodsViewVoMap() {
		return resourceGoodsViewVoMap;
	}

	public void setResourceGoodsViewVoMap(
			Map<String, ResourceGoodsViewVo> resourceGoodsViewVoMap) {
		this.resourceGoodsViewVoMap = resourceGoodsViewVoMap;
	}

	public ResourceMgpriceViewVo getResourceMgpriceViewVos() {
		return resourceMgpriceViewVos;
	}

	public void setResourceMgpriceViewVos(
			ResourceMgpriceViewVo resourceMgpriceViewVos) {
		this.resourceMgpriceViewVos = resourceMgpriceViewVos;
	}

	public ResourceMgpriceVo getResourceMgpriceVo() {
		return resourceMgpriceVo;
	}

	public void setResourceMgpriceVo(ResourceMgpriceVo resourceMgpriceVo) {
		this.resourceMgpriceVo = resourceMgpriceVo;
	}
	

	public List<ResourceGpriceVo> getResourceGpriceVoList() {
		return resourceGpriceVoList;
	}

	public void setResourceGpriceVoList(List<ResourceGpriceVo> resourceGpriceVoList) {
		this.resourceGpriceVoList = resourceGpriceVoList;
	}


	@Override
	public String execute() {			
		// 查询标书信息
		ginfoBillno = getParameter("ginfoBillno");
		if (StringUtil.isNotBlank(getParameter("ginfoLnum"))) {
			ginfoLnum = Long.valueOf(getParameter("ginfoLnum"));
			if (null==ginfoLnum) {ginfoLnum=(long) 1;}
			resourceGinfoViewVo = getresourceGinfoViewVo(ginfoBillno,ginfoLnum);
		}
		//供应商报价明细
		if (null != resourceGinfoViewVo.getGlistTempbatch()) {
			resourceGlistViewVos = getResourceGlistViewVos(resourceGinfoViewVo.getGlistTempbatch());
			packagingGlistViewVo(resourceGlistViewVos, tenderQuotationViewVos);
		}
		return SUCCESS;
	}
	
	// 根据ginfoBillNo，ginfoLnum获取标书信息
		private ResourceGinfoViewVo getresourceGinfoViewVo (String ginfoBillNo,Long ginfoLnum) {
			Map<String, Object> map = new HashMap<String, Object>();
			queryBeanVo.setCmemberCode(getUserSession().getCmemberCode());
			queryBeanVo.setGinfoBillno(ginfoBillNo);
			queryBeanVo.setGinfoLnum(ginfoLnum);
			//queryBeanVo.setWhereStr(" and ginfoProperty != '3'");
			map.put("queryBean", queryBeanVo);
			// 获取项目标书主信息
			ResourceGinfoRe resourceGinfoRe = getServiceInvoker().callAsObject(
						"resourceGinfoService.queryInfo", map, ResourceGinfoRe.class);
			if (null == resourceGinfoRe) resourceGinfoRe = new ResourceGinfoRe();
			return resourceGinfoRe.getList() == null ? new ResourceGinfoViewVo() : resourceGinfoRe.getList().get(0);
		}

	/**
	 * 
	 * @Project purexchange
	 * @Package com.soft.exchange.biz.purchase.action
	 * @Method getParameter方法.<br>
	 * @Description TODO(获取request)
	 * @param paramName
	 * @return
	 */
	private String getParameter(String paramName) {
		return ServletActionContext.getRequest().getParameter(paramName);
	}


	//查询物料表RESOURCE_GLIST
	private List<ResourceGlistViewVo> getResourceGlistViewVos(String glistTempbatch) {
		params = new HashMap<String, Object>();
		ListQueryVo listQueryVo = new ListQueryVo();
		this.buildPaging(listQueryVo);
		listQueryVo.setGlistTempbatch(glistTempbatch);
		listQueryVo.setCmemberCode(this.getUserSession().getCmemberCode());
		listQueryVo.setOrderBy("to_number(goodsEntrybatchold) asc");
		params.put("listQueryVo", listQueryVo);
		QueryResourceGlistVo queryResourceGlistVo = this.getServiceInvoker().callAsObject("resourceService.queryResourceGlistViewVo", params, QueryResourceGlistVo.class);
		if (null == queryResourceGlistVo) {
			queryResourceGlistVo = new QueryResourceGlistVo();
		} else {
			this.getPaging().setTotalCount(queryResourceGlistVo.getPageTools().getRecordCount());
		}
		return queryResourceGlistVo.getList() == null ? new ArrayList<ResourceGlistViewVo>() : queryResourceGlistVo.getList();
	}

	
	// 根据标书编号查询上一轮标书glistTempbatch
	@SuppressWarnings("unused")
	private ResourceGinfoViewVo getresourceGinfoViewVoOld (String ginfoNumber,Long ginfoLnum ) {
		Map<String, Object> map = new HashMap<String, Object>();
		QueryBean queryBeanVo = new QueryBean();
		queryBeanVo.setCmemberCode(getUserSession().getCmemberCode());
		queryBeanVo.setGinfoNumber(ginfoNumber);
		queryBeanVo.setGinfoLnum(ginfoLnum-1);
		map.put("queryBean", queryBeanVo);
		// 获取项目标书主信息
		ResourceGinfoRe resourceGinfoReOld = getServiceInvoker().callAsObject(
					"resourceGinfoService.queryInfo", map, ResourceGinfoRe.class);
		if (resourceGinfoReOld == null) resourceGinfoReOld = new ResourceGinfoRe();
		return resourceGinfoReOld.getList() == null ? new ResourceGinfoViewVo() : resourceGinfoReOld.getList().get(0);
	}
	
	
	//查询报价明细
	private void packagingGlistViewVo(List<ResourceGlistViewVo> resourceGlistViewVos, List<TenderQuotationViewVo> tenderQuotationViewVos) {
		for (ResourceGlistViewVo resourceGlistViewVo : resourceGlistViewVos) {
			TenderQuotationViewVo tenderQuotationViewVo = new TenderQuotationViewVo();
			try {
				BeanUtils.copyProperties(tenderQuotationViewVo, resourceGlistViewVo);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
			if (null != resourceGlistViewVo.getGlistBillbatch() && null != resourceGlistViewVo.getGlistTempbatch()) {
				ResourceGoodsViewVo resourceGoodsViewVo = getResourceGoodsViewVo(resourceGlistViewVo.getGlistBillbatch(), resourceGlistViewVo.getGlistTempbatch());
				if (null == resourceGoodsViewVo)
					continue;
					tenderQuotationViewVo.setGoodsProperty5(resourceGoodsViewVo.getGoodsProperty5());
					tenderQuotationViewVo.setGoodsProperty4(resourceGoodsViewVo.getGoodsProperty4());
					tenderQuotationViewVo.setGoodsRemark(resourceGoodsViewVo.getGoodsRemark());
					//tenderQuotationViewVo.setGoodsNum(resourceGoodsViewVo.getGoodsNum());
				if(resourceGinfoViewVo.getGinfoType().equals("10"))
				{
					ResourceMemgpriceViewVo resourceMemgpriceViewVo = getResourceMemgpriceViewVo(resourceGlistViewVo.getGlistBillbatch(), resourceGlistViewVo.getGlistTempbatch());
					if (null == resourceMemgpriceViewVo ) resourceMemgpriceViewVo = new ResourceMemgpriceViewVo();
					//resourceMemgpriceViewVo = getResourceMemgprice(resourceGlistViewVo.getGlistBillbatch(), resourceGlistViewVo.getGlistTempbatch());
					tenderQuotationViewVo.setPricesetPrice(resourceMemgpriceViewVo.getPricesetPrice());
					tenderQuotationViewVo.setGoodsNumKh(resourceMemgpriceViewVo.getGoodsNum());
					tenderQuotationViewVo.setGpriceCurrency(resourceMemgpriceViewVo.getGpriceCurrency());
				
				}
				else
				{
					ResourceGpriceViewVo resourceGpriceViewVoNew = getResourceGpriceViewVoNew(resourceGlistViewVo.getGlistTempbatch(),resourceGlistViewVo.getGlistBillbatch());
					if (null == resourceGpriceViewVoNew) resourceGpriceViewVoNew = new ResourceGpriceViewVo();
					//resourceMemgpriceViewVo = getResourceMemgprice(resourceGlistViewVo.getGlistBillbatch(), resourceGlistViewVo.getGlistTempbatch());
					tenderQuotationViewVo.setPricesetPrice(resourceGpriceViewVoNew.getPricesetPrice());
					tenderQuotationViewVo.setPricesetAprice(resourceGpriceViewVoNew.getPricesetAprice());	
					tenderQuotationViewVo.setGoodsNumKh(resourceGpriceViewVoNew.getGoodsNum());
					tenderQuotationViewVo.setGpriceCurrency(resourceGpriceViewVoNew.getGpriceCurrency());
				}
				
			}
			tenderQuotationViewVos.add(tenderQuotationViewVo);
		}
	}


    //查询物料信息
	private ResourceGoodsViewVo getResourceGoodsViewVo(String glistBillbatch, String glistTempbatch) {
		if (null == resourceGoodsMap) {
			resourceGoodsMap = new HashMap<String, ResourceGoodsViewVo>();
			params = new HashMap<String, Object>();
			GoodsQueryVo goodsQueryVo = new GoodsQueryVo();
			goodsQueryVo.setCmemberCode(this.getUserSession().getCmemberCode());
			goodsQueryVo.setGlistTempbatch(glistTempbatch);
			params.put("goodsQueryVo", goodsQueryVo);
			QueryResourceGoodsVo queryResourceGoodsVo = this.getServiceInvoker().callAsObject("resourceService.queryResourceGoods", params, QueryResourceGoodsVo.class);
			if (null == queryResourceGoodsVo)
				queryResourceGoodsVo = new QueryResourceGoodsVo();
			if (null != queryResourceGoodsVo.getList()) {
				for (ResourceGoodsViewVo resourceGoodsViewVo : queryResourceGoodsVo.getList()) {
					resourceGoodsMap.put(resourceGoodsViewVo.getGlistBillbatch(), resourceGoodsViewVo);
				}
			}
		}
		return resourceGoodsMap.get(glistBillbatch);
	}


	//查询最新报价信息
		@SuppressWarnings("unchecked")
		private ResourceGpriceViewVo getResourceGpriceViewVoNew(String glistTempbatch, String glistBillbatch) {
			if (null == gPriceMapNew) {
				gPriceMapNew = new HashMap<String, ResourceGpriceViewVo>();
			com.soft.bc.resource.gprice.vo.MgpriceQueryBean mgpriceQueryBean = new com.soft.bc.resource.gprice.vo.MgpriceQueryBean();
			Map<String, Object> mapMgprice = new HashMap<String, Object>();
			mgpriceQueryBean.setCmemberCode(this.getUserSession().getCmemberCode());
			mgpriceQueryBean.setGlistTempbatch(glistTempbatch);
			mgpriceQueryBean.setMemberCode(this.getUserSession().getMemberCode());
			//mgpriceQueryBean.setWhereStr(" exists (select 1 from ResourceGprice where mgpriceBatch = a.mgpriceBatch and dataBillstate = '1' )");
			mgpriceQueryBean.setQueryOrderStr1("pricesetRound desc");
			mapMgprice.put("queryBean", mgpriceQueryBean);
			List<ResourceMgpriceViewVo> resourceMgpriceViewVos = (List<ResourceMgpriceViewVo>) getServiceInvoker()
					.callAsList("resourceGpriceService.queryMgpriceList", mapMgprice, ResourceMgpriceViewVo.class);
			Long pricesetRound = 0L;
			if (resourceMgpriceViewVos != null) {
				if(resourceMgpriceViewVos.get(0).getDataBillstate().equals(1L)){
				pricesetRound = resourceMgpriceViewVos.get(0).getPricesetRound(); //获次取最新轮次
				}
				else
				{
					pricesetRound = resourceMgpriceViewVos.get(0).getPricesetRound()-1;
				}
			}
			com.soft.bc.resource.gprice.vo.QueryBean gpriceQueryBean = new com.soft.bc.resource.gprice.vo.QueryBean();
			Map<String, Object> mapGprice = new HashMap<String, Object>();
			gpriceQueryBean.setCmemberCode(this.getUserSession().getCmemberCode());
			gpriceQueryBean.setGlistTempbatch(glistTempbatch);
			gpriceQueryBean.setMemberCode(this.getUserSession().getMemberCode());
			gpriceQueryBean.setPricesetRound(pricesetRound);
			gpriceQueryBean.setDataBillstate(1L);
			mapGprice.put("queryBean", gpriceQueryBean);
			//获取指定报价轮次下，所有的报价信息
			ResourceGpriceRe resourceGpriceRe = this.getServiceInvoker()
					.callAsObject("resourceGpriceService.queryResourceGprice", mapGprice, ResourceGpriceRe.class);
			if (null == resourceGpriceRe) resourceGpriceRe = new ResourceGpriceRe();
			for (ResourceGpriceViewVo resourceGpriceViewVo : resourceGpriceRe.getList()) {
				if (StringUtil.isBlank(gPriceMapNew.get(resourceGpriceViewVo.getGlistBillbatch()))) {
					gPriceMapNew.put(resourceGpriceViewVo.getGlistBillbatch(), resourceGpriceViewVo);
				}
			}
			}
		    return gPriceMapNew.get(glistBillbatch);	
		}
		
		
		//公开竞拍查询最新报价信息
		// 查询最新报价信息
		private ResourceMemgpriceViewVo getResourceMemgpriceViewVo(String glistBillbatch, String glistTempbatch) {
			if (null == memgPriceMap) {
				memgPriceMap = new HashMap<String, ResourceMemgpriceViewVo>();
				params = new HashMap<String, Object>();
				com.soft.bc.resource.gprice.vo.QueryBean queryBean = new com.soft.bc.resource.gprice.vo.QueryBean();
				queryBean.setCmemberCode(this.getUserSession().getCmemberCode());
				queryBean.setGlistTempbatch(glistTempbatch);
				params.put("queryBean", queryBean);
				ResourceMemgpriceRe resourceMemgpriceRe = this.getServiceInvoker().callAsObject("resourceGpriceService.queryMemgpriceList", params, ResourceMemgpriceRe.class);
				if (null == resourceMemgpriceRe) resourceMemgpriceRe = new ResourceMemgpriceRe();
				for (ResourceMemgpriceViewVo resourceMemgpriceViewVo : resourceMemgpriceRe.getList()) {
					if (resourceMemgpriceViewVo.getMemberCode().equals(this.getUserSession().getMemberCode()))
					memgPriceMap.put(resourceMemgpriceViewVo.getGlistBillbatch(), resourceMemgpriceViewVo);
				}
			}
			return (null == memgPriceMap || memgPriceMap.isEmpty()) ? new ResourceMemgpriceViewVo() : memgPriceMap.get(glistBillbatch);
		}
				
	
	@SuppressWarnings("unchecked")
	public Map<String, String> getExcelMap(UserSession userSession) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cmemberCode", userSession.getCmemberCode());
		Map<String, String> columnNameMap = getServiceInvoker().callAsObject(
				"resourceService.getExcelMap", map, Map.class);
		return columnNameMap;
	}

	public String showMoreInfo(){
		DepositQueryBean depositQueryBean = new DepositQueryBean();
		depositQueryBean.setDataBillstate(Long.valueOf(0L));

		Map map2 = new HashMap();
		depositQueryBean.setCmemberCode("S000026");
		depositQueryBean.setMemberCode(getUserSession().getMemberCode());
		map2.put("depositQueryBean", depositQueryBean);
		this.queryReDeposit = ((QueryReDeposit)getServiceInvoker().callAsObject("balanceDepositService.queryBalanceDepositByPage", map2, QueryReDeposit.class));
		if (this.queryReDeposit != null) {
			for (BalanceDepositViewVo balanceDepositViewVo : this.queryReDeposit.getList()) {
				balanceDepositViewVo.setDepositMoney(0.00D);
				this.depositmap.put(balanceDepositViewVo.getMemberBcode(), balanceDepositViewVo);
			}

			DepositListQueryBean depositListQueryBean2 = new DepositListQueryBean();
			depositListQueryBean2.setCmemberCode("S000026");

			depositListQueryBean2.setWhereStr("memberCode ='" + getUserSession().getMemberCode() + "' and dataBillstate = 10 ");
			Map map3 = new HashMap();

			map3.put("depositListQueryBean", depositListQueryBean2);

			QueryReDepositList queryReDepositList2 = (QueryReDepositList)getServiceInvoker().callAsObject("balanceDepositService.queryBalanceDepositListByPage", map3, QueryReDepositList.class);

			if (queryReDepositList2 != null) {
				for (BalanceDepositListVo balanceDepositListVo : queryReDepositList2.getList())
				{
					BalanceDepositViewVo balanceDepositViewVo = (BalanceDepositViewVo)this.depositmap.get(balanceDepositListVo.getMemberBcode());
					balanceDepositViewVo.setDepositMoney(Double.valueOf(balanceDepositListVo.getDepositListMoney().doubleValue())+balanceDepositViewVo.getDepositMoney().doubleValue());
					this.depositmap.put(balanceDepositViewVo.getMemberBcode(), balanceDepositViewVo);
				}
			}
		}

		Map maptt = new HashMap();
		com.soft.bc.resource.ginfo.vo.QueryBean queryBeantt = new com.soft.bc.resource.ginfo.vo.QueryBean();
		queryBeantt.setCmemberCode("S000026");
		queryBeantt.setGoodsType("7");
		queryBeantt.setDataBillstateIn("5,7,8,10,20,13,28");
		queryBeantt.setGlistTempbatch(this.glistTempbatch_states);
		queryBeantt.setQueryOrderStr1(" ginfoSdate desc");
		maptt.put("queryBean", queryBeantt);
		try {
			ResourceGinfoRe resourceGinfoRe = (ResourceGinfoRe)getServiceInvoker().callAsObject("resourceGinfoService.queryInfo", maptt, ResourceGinfoRe.class);
			if (resourceGinfoRe != null)
				setResourceGinfoList(resourceGinfoRe.getList());
		}
		catch (BusinessException e) {
			setErrorInfo(e.getMessage());
		}

		this.msgMap1 = new HashMap();
		Map map = new HashMap();
		map.put("cmemberCode", Session.getUserSession().getCmemberCode());
		map.put("memberCode", Session.getUserSession().getMemberCode());
		Map ginfoListMap = new HashMap();
		ginfoListMap.put("cmemberCode", Session.getUserSession().getCmemberCode());
		ginfoListMap.put("memberCode", Session.getUserSession().getMemberCode());
		ginfoListMap.put("glistTempbatch", this.glistTempbatch_states);
		GinfoListViewVo ginfoListViewVo = (GinfoListViewVo)getServiceInvoker().callAsObject("ginfoListService.getByMemberCode", ginfoListMap, GinfoListViewVo.class);
		if (ginfoListViewVo != null) {
			this.resourceGinfoListList.add(ginfoListViewVo);
			if (StringUtil.isBlank(ginfoListViewVo.getPricesetMoneyFlag()))this.priceSetMoneyFlagMap.put(this.glistTempbatch_states, "0");
			else this.priceSetMoneyFlagMap.put(this.glistTempbatch_states, ginfoListViewVo.getPricesetMoneyFlag());

		}

		map.clear();

		String glistTempbatch = "";
		Long dataBillstate = Long.valueOf(-1L);
		Map msgMap = new HashMap();
		MgpriceQueryBean mgpQueryBean = new MgpriceQueryBean();
		mgpQueryBean.setCmemberCode(Session.getUserSession().getCmemberCode());
		mgpQueryBean.setMemberCode(Session.getUserSession().getMemberCode());
		mgpQueryBean.setGlistTempbatch(this.glistTempbatch_states);
		mgpQueryBean.setDataBillstate(1L);
		//mgpQueryBean.setPricesetRound(Long.valueOf(1L));
		mgpQueryBean.setWhereStr(" not exists(select 1 from ResourceMgprice where a.mgpriceBatch=mgpriceBatch and a.pricesetRound<pricesetRound) ");
		Map mgpQueryMap = new HashMap();
		mgpQueryMap.put("queryBean", mgpQueryBean);
		try {
			List resourceMgpriceViewVos = getServiceInvoker().callAsList("resourceGpriceService.queryMgpriceList", mgpQueryMap, ResourceMgpriceViewVo.class);
			if ("0".equals(this.resourceGinfoViewVo.getPricesetDt())){
				if (ginfoListViewVo != null)
					if (ginfoListViewVo.getDataBillstate().longValue() == 1L)
					{
						this.resourceGinfoViewVo.setScontractEtype(ginfoListViewVo.getPricesetState());
					}
					else {
						this.resourceGinfoViewVo.setScontractEtype("2");
					}
			}else if (ginfoListViewVo != null)
				this.resourceGinfoViewVo.setScontractEtype(ginfoListViewVo.getPricesetState());
			else {
				this.resourceGinfoViewVo.setScontractEtype("2");
			}

			if ((resourceMgpriceViewVos != null) && (resourceMgpriceViewVos.size() > 0)) {
				Long dataBillstate1 = ((ResourceMgpriceViewVo)resourceMgpriceViewVos.get(0)).getDataBillstate();
				this.msgMap1.put(this.glistTempbatch_states, dataBillstate1);
			} else {
				this.msgMap1.put(this.glistTempbatch_states, Long.valueOf(0L));
			}
		} catch (BusinessException e) {
			setErrorInfo(e.getMessage());
		}

		return "showMoreInfo";
	}

public HashMap<String, BalanceDepositViewVo> getDepositmap() {
	return depositmap;
}

public void setDepositmap(HashMap<String, BalanceDepositViewVo> depositmap) {
	this.depositmap = depositmap;
}

public Map<String, Object> getMsgMap1() {
	return msgMap1;
}

public void setMsgMap1(Map<String, Object> msgMap1) {
	this.msgMap1 = msgMap1;
}

public List<GinfoListViewVo> getResourceGinfoListList() {
	return resourceGinfoListList;
}

public void setResourceGinfoListList(List<GinfoListViewVo> resourceGinfoListList) {
	this.resourceGinfoListList = resourceGinfoListList;
}

public List<ResourceGinfoViewVo> getResourceGinfoList() {
	return resourceGinfoList;
}

public void setResourceGinfoList(List<ResourceGinfoViewVo> resourceGinfoList) {
	this.resourceGinfoList = resourceGinfoList;
}


public Map<String, String> getPriceSetMoneyFlagMap() {
	return priceSetMoneyFlagMap;
}

public void setPriceSetMoneyFlagMap(Map<String, String> priceSetMoneyFlagMap) {
	this.priceSetMoneyFlagMap = priceSetMoneyFlagMap;
}

public String getGlistTempbatch_states() {
	return glistTempbatch_states;
}

public void setGlistTempbatch_states(String glistTempbatch_states) {
	this.glistTempbatch_states = glistTempbatch_states;
}

public QueryReDeposit getQueryReDeposit() {
	return queryReDeposit;
}

public void setQueryReDeposit(QueryReDeposit queryReDeposit) {
	this.queryReDeposit = queryReDeposit;
}


}


	
