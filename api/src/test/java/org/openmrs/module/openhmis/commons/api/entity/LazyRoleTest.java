package org.openmrs.module.openhmis.commons.api.entity;

import java.util.List;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.openmrs.Role;
import org.openmrs.api.UserService;
import org.openmrs.api.context.Context;
import org.openmrs.module.openhmis.commons.api.TestConstants;
import org.openmrs.test.BaseModuleContextSensitiveTest;

public class LazyRoleTest extends BaseModuleContextSensitiveTest {
	public static final String BILL_DATASET = TestConstants.BASE_DATASET_DIR + "BillTest.xml";
	
	private UserService userService;
	
	@Before
	public void before() throws Exception {
		executeDataSet(TestConstants.CORE_DATASET);
		
		userService = Context.getUserService();
	}
	
	@Test
	public void selectAll_ShouldReturnAllRoles() throws Exception {
		List<Role> roles = userService.getAllRoles();
		
		Assert.assertEquals(8, roles.size());
	}
}
