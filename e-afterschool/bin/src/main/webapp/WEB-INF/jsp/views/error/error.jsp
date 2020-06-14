<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="page-content">
	<div class="content-wrapper">
		<div class="content d-flex justify-content-center align-items-center">
			<div class="flex-fill">
				<div class="text-center mb-3">
					<h1 class="error-title">${status}</h1>
				</div>
				<div class="mb-3">
					<h5>
						<span class="font-weight-semibold">Error :</span> 
						<span class="text-primary">${error}</span>
					</h5>
					<h5>
						<span class="font-weight-semibold">Message :</span> 
						<span class="text-primary">${message}</span>
					</h5>
					<h5>
						<span class="font-weight-semibold">Exception :</span> 
						<span class="text-primary">
							${exception}
						</span>
					</h5>
					<h5>
						<span class="font-weight-semibold">Description :</span> 
						<span class="text-primary">${trace}</span>
					</h5>
				</div>
			</div>
		</div>
	</div>
</div>