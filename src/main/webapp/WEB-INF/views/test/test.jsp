<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	const json = {
			강좌 관리: [
				'강좌1', '강좌2', '강좌3'
			],
			수강 관리: [
				'강좌1', '강좌2', '강좌3'
			],
			수강생 관리: [
				'강좌1', '강좌2', '강좌3'
			]
	}
	// 컨트롤러에서 model.addAttribute('menu', '강좌 관리');
	const tag = ${menu};
	
	const arr = json[tag]; 
	
	for(let i=0; i<arr.length; i++){
		let subMenu = `<span>` + json[tag][i] + `</span>`;
		
		$(".menu-list-box").append(subMenu);
	}
		
</script>
<body>
	<span>test</span>
</body>
</html>