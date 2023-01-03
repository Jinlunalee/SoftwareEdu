	/* 모달창 열기 */
	const body = document.querySelector('body');
    const modal = document.querySelector('.modal');
    const btnOpenPopup = document.querySelector('.btn-open-popup');

    btnOpenPopup.addEventListener('click', () => {
      modal.classList.toggle('show'); // class를 이용한 모달 on

      if (modal.classList.contains('show')) { // 모달이 on일 때
        body.style.overflow = 'hidden'; // body의 스크롤을 막음
      }
    });

    modal.addEventListener('click', (event) => {
      if (event.target === modal) {
        modal.classList.toggle('show'); // class를 이용한 모달 on

        if (!modal.classList.contains('show')) { // 모달이 off일 때
          body.style.overflow = 'auto';  // body의 스크롤을 풂
        }
      }
    });
    
    /* 모달창 닫기 */
    const closeBtn = modal.querySelector(".close-btn");
    
    $(closeBtn).click(function(){
		modal.classList.remove('show');
		console.log("it's working");
	});
   