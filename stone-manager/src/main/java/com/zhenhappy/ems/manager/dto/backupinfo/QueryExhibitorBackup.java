package com.zhenhappy.ems.manager.dto.backupinfo;

import java.util.Date;

/**
 * Created by wangxd on 2016-12-19.
 */
public class QueryExhibitorBackup {
	private Integer id;
	private Integer eid;
	private String username;
	private String password;
	private Integer level;
	private String company;
	private String companye;
	private Integer country;
	private Integer province;
	private Date lastLoginTime;
	private String lastLoginIp;
	private Integer isLogout;
	private Integer isLogin;
	private Integer createUser;
	private Date createTime;
	private Integer updateUser;
	private Date updateTime;
	private String boothNumber;
	private String exhibitionArea;
	private Integer tag;
	private Integer infoFlag;
	private Integer area;
	private Integer group;
	private String contractId;

	public QueryExhibitorBackup() {
		super();
	}

	public QueryExhibitorBackup(Integer id) {
		super();
		this.id = id;
	}

	public QueryExhibitorBackup(Integer id, Integer eid, String company, String companye) {
		super();
		this.id = id;
		this.eid = eid;
		this.company = company;
		this.companye = companye;
	}

	public QueryExhibitorBackup(Integer id, Integer eid, String username, String password, Integer area, String company,
								String companye, Integer country, Integer province, Integer isLogout, Integer isLogin,
								Integer tag, Integer group, String boothNumber, String exhibitionArea, String contractId,
								Date updateTime) {
		super();
		this.id = id;
		this.eid = eid;
		this.username = username;
		this.password = password;
		this.company = company;
		this.companye = companye;
		this.country = country;
		this.province = province;
		this.isLogout = isLogout;
		this.isLogin= isLogin;
		this.boothNumber = boothNumber;
		this.exhibitionArea = exhibitionArea;
		this.tag = tag;
		this.area = area;
		this.group = group;
		this.contractId = contractId;
		this.updateTime = updateTime;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getEid() {
		return eid;
	}

	public void setEid(Integer eid) {
		this.eid = eid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getCompanye() {
		return companye;
	}

	public void setCompanye(String companye) {
		this.companye = companye;
	}

	public Integer getCountry() {
		return country;
	}

	public void setCountry(Integer country) {
		this.country = country;
	}

	public Integer getProvince() {
		return province;
	}

	public void setProvince(Integer province) {
		this.province = province;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String getLastLoginIp() {
		return lastLoginIp;
	}

	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}

	public Integer getIsLogout() {
		return isLogout;
	}

	public void setIsLogout(Integer isLogout) {
		this.isLogout = isLogout;
	}

	public Integer getCreateUser() {
		return createUser;
	}

	public void setCreateUser(Integer createUser) {
		this.createUser = createUser;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(Integer updateUser) {
		this.updateUser = updateUser;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getBoothNumber() {
		return boothNumber;
	}

	public void setBoothNumber(String boothNumber) {
		this.boothNumber = boothNumber;
	}

	public String getExhibitionArea() {
		return exhibitionArea;
	}

	public void setExhibitionArea(String exhibitionArea) {
		this.exhibitionArea = exhibitionArea;
	}

	public Integer getTag() {
		return tag;
	}

	public void setTag(Integer tag) {
		this.tag = tag;
	}

	public Integer getInfoFlag() {
		return infoFlag;
	}

	public void setInfoFlag(Integer infoFlag) {
		this.infoFlag = infoFlag;
	}

	public Integer getArea() {
		return area;
	}

	public void setArea(Integer area) {
		this.area = area;
	}

	public Integer getGroup() {
		return group;
	}

	public void setGroup(Integer group) {
		this.group = group;
	}

	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

	public Integer getIsLogin() {
		return isLogin;
	}

	public void setIsLogin(Integer isLogin) {
		this.isLogin = isLogin;
	}
}
