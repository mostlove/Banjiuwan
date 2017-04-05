package com.magicbeans.banjiuwan.exception;

/**
 * 通用接口异常类.
 */
public class InterfaceCommonException extends RuntimeException {

	private static final long serialVersionUID = 8702302085609579029L;

	/**
	 * 异常编码.
	 */
	private int errorCode;

	public int getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}

	public InterfaceCommonException(int errorCode, String message) {
		super(message);

		this.errorCode = errorCode;
	}
}

