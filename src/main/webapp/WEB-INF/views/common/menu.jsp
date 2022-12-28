<%@ page contentType="text/html; charset=UTF-8"%>

<h6 class="text-white">
	<div class="aside-bar">
		<div class="aside-bar-menu">
			<div class="menu-text">${menuKOR}</div>
		</div>
		<div class="aside-bar-submenu">
		</div>
	</div>
</h6>
	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	<script>
		var submenuItems = document.getElementsByClassName("submenu-items");
		
		function Click(event) {
			console.log(event.target);
			console.log(event.target.classList);
	
			if (event.target.classList[1] === "clicked") {
				event.target.classList.remove("clicked");
			} else {
				for (var i = 0; i < submenuItems.length; i++) {
					submenuItems[i].classList.remove("clicked");
				}
	
				event.target.classList.add("clicked");
			}
		}
	
		function init() {
			for (var i = 0; i < submenuItems.length; i++) {
				submenuItems[i].addEventListener("click", Click);
			}
		}
		
		init();
		
	</script>
