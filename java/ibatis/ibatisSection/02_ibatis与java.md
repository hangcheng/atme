## ibatis java使用
### SqlMapClientTemplate和SqlMapClient
~~~
SqlMapClientTemplate是SqlMapClient的封装类. 
SqlMapClient中包含着session的管理. 
SqlMapClientTemplate用于session的封装,以及异常的捕捉. 
所以按照以上的推断来说.应该尽量使用SqlMapClientTemplate. 
保证session以及Exception的正常以及统一.
~~~
### java 封装
~~~
	private SqlMapClientTemplate sqlMapClientTemplate = null;
	private TransactionTemplate transactionTemplate = null;

	public void setSqlMapClientTemplate(
			SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	public void setTransactionTemplate(TransactionTemplate transactionTemplate) {
		this.transactionTemplate = transactionTemplate;
	}

	public SqlMapClientTemplate getSqlMapClientTemplate() {
		return sqlMapClientTemplate;
	}
/**
	 * 查询返回List
	 * 
	 * @param sqlId
	 * @param obj
	 * @return
	 * @throws Exception
	 */
	public List<Object> queryForList(String sqlId, Object obj) {
		return sqlMapClientTemplate.queryForList(sqlId, obj);
	}
	
	/**
	 * 分页查询返回List
	 * 
	 * @param sqlId
	 * @param obj
	 * @return
	 * @throws Exception
	 */
	public List<Object> queryForList(String sqlId, Object obj ,int start,int limit) {
		return sqlMapClientTemplate.queryForList(sqlId, obj, start, limit);
	}

	/**
	 * 查询返回(clazz)Object
	 * 
	 * @param sqlId
	 * @param obj
	 * @param clazz
	 * @return
	 * @throws Exception
	 */
	public Object queryForObject(String sqlId, Object obj, Class clazz) {
		return clazz.cast(sqlMapClientTemplate.queryForObject(sqlId, obj));
	}
/**
	 * 非事务新增
	 * 
	 * @param sqlId
	 * @param obj
	 * @return
	 */
	public Object insert(String sqlId, Object obj) {
		return sqlMapClientTemplate.insert(sqlId, obj);
	}

	/**
	 * 非事务修改
	 * 
	 * @param sqlId
	 * @param obj
	 * @return
	 */
	public int update(String sqlId, Object obj) {
		return sqlMapClientTemplate.update(sqlId, obj);
	}

	/**
	 * 非事务删除
	 * 
	 * @param sqlId
	 * @param obj
	 * @return
	 */
	public int delete(String sqlId, Object obj) {
		return sqlMapClientTemplate.delete(sqlId, obj);

	}

	/**
	 * 批量事务处理 0增加1修改（调用存储过程）3删除    推荐使用
	 * 
	 * @param doType
	 * @param statementID
	 * @param paramObjs
	 * @return
	 */
	public int executeBatchDB(final int doType, final String statementID,
			final List paramObjs) {
		int result = -1;
		result = ((Integer) transactionTemplate
				.execute(new TransactionCallback() {

					public Object doInTransaction(TransactionStatus status) {
						Integer rstObj = new Integer(-1);
						try {
							rstObj = exeBatch(doType, statementID, paramObjs);
						} catch (Exception e) {
							status.setRollbackOnly();
							e.printStackTrace();
							return new Integer(-1);
						}
						return rstObj;
					}
				})).intValue();
		return result;
	}

	public Integer exeBatch(final int doType, final String sqlId,
			final List args) {
		Integer result = new Integer(-1);
		SqlMapClientCallback callback = new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {
				Integer rows = new Integer(-1);
				executor.startBatch();
				for (int i = 0; i < args.size(); i++) {
					switch (doType) {
					case 0: {
						executor.insert(sqlId, args.get(i));
						break;
					}
					case 1: {
						executor.update(sqlId, args.get(i));
						break;
					}
					case 2: {
						executor.delete(sqlId, args.get(i));
						break;
					}
					}
				}
				rows = new Integer(executor.executeBatch());
				return rows;
			}
		};
		if (sqlId != null && args != null && !args.isEmpty()) {
			result = (Integer) sqlMapClientTemplate.execute(callback);
		}
		return result;
	}

	/**
	 * 批量事务处理 0增加1修改（调用存储过程）3删除
	 * 
	 * @param doType
	 * @param sqlIds
	 * @param args
	 * @return
	 */
	public int executeBatchDB(final int doType, final List<String> sqlIds,
			final List args) {
		int result = -1;
		result = ((Integer) transactionTemplate
				.execute(new TransactionCallback() {
					public Object doInTransaction(TransactionStatus status) {
						Integer rstObj = new Integer(-1);
						try {
							rstObj = exeBatchDB(doType, sqlIds, args);
						} catch (Exception e) {
							status.setRollbackOnly();
							e.printStackTrace();
							return new Integer(-1);
						}
						return rstObj;
					}
				})).intValue();
		return result;
	}

	private Integer exeBatchDB(final int doType, final List<String> sqlIds,
			final List args) {
		Integer result = new Integer(-1);
		SqlMapClientCallback callback = new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {
				Integer rows = new Integer(-1);
				executor.startBatch();
				for (String sqlId : sqlIds) {
					for (int i = 0; i < args.size(); i++) {
						switch (doType) {
						case 0: {
							executor.insert(sqlId, args.get(i));
							break;
						}
						case 1: {
							executor.update(sqlId, args.get(i));
							break;
						}
						case 2: {
							executor.delete(sqlId, args.get(i));
							break;
						}
						}
					}
				}
				rows = new Integer(executor.executeBatch());
				return rows;
			}
		};
		if (sqlIds != null && !sqlIds.isEmpty() && args != null
				&& !args.isEmpty()) {
			result = (Integer) sqlMapClientTemplate.execute(callback);
		}
		return result;
	}
~~~