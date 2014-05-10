/**
 * <pre>
 * Copyright:		Copyright(C) 2011-2012, hxhk.com
 * Filename:		com.ygsoft.util.dwz.SpringDataJpaPageConvert.java
 * Class:			SpringDataJpaPageConvert
 * Date:			2012-8-6
 * Author:			<a href="mailto:hxhk@gmail.com">hxhk</a>
 * Version          1.1.0
 * Description:		
 *
 * </pre>
 **/

package com.hxhk.util.dwz.springdata;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.hxhk.util.dwz.PageInfo;

/**
 * 解决dwz page 的遗留问题，使程序更易移植和替换
 * 
 * @author <a href="mailto:hxhk@gmail.com">hxhk</a> Version 1.1.0
 * @since 2012-8-6 下午10:03:18
 */

public class PageUtils {

	/**
	 * 生成spring data JPA 对象 描述
	 * 
	 * @param pageInfo
	 * @return
	 */
	public static Pageable createPageable(PageInfo pageInfo) {
		if (StringUtils.isNotBlank(pageInfo.getOrderField())) {
			// 忽略大小写
			if (pageInfo.getOrderDirection().equalsIgnoreCase(PageInfo.ORDER_DIRECTION_ASC)) {
				return new PageRequest(pageInfo.getPlainPageNum() - 1, pageInfo.getNumPerPage(), 
						Sort.Direction.ASC, pageInfo.getOrderField());
			} else {
				return new PageRequest(pageInfo.getPlainPageNum() - 1, pageInfo.getNumPerPage(), 
						Sort.Direction.DESC, pageInfo.getOrderField());
			}
		}

		return new PageRequest(pageInfo.getPlainPageNum() - 1, pageInfo.getNumPerPage());
	}

	/**
	 * 将springDataPage的属性注入page 描述
	 * 
	 * @param pageInfo
	 * @param springDataPage
	 */
	public static void injectPageProperties(PageInfo pageInfo,
			org.springframework.data.domain.Page<?> springDataPage) {
		pageInfo.setTotalCount((int)springDataPage.getTotalElements());
	}
}
