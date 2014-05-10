package com.hxhk.util.log;

import org.aspectj.lang.JoinPoint;

public interface ILogService {
    //无参的日志方法
    public void log();
    //有参的日志方法
    public void logArg(JoinPoint point);
    //有参有返回值的方法
    public void logArgAndReturn(JoinPoint point,Object returnObj);
}
