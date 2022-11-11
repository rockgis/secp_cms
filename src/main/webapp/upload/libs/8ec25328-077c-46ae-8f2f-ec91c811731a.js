var x = "127.030999";
					var y = "37.258297";
					var title = "미디어코어시스템즈";
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
							mapOption = {
								center: new daum.maps.LatLng(y, x), // 지도의 중심좌표
								level: 4, // 지도의 확대 레벨
								mapTypeId : daum.maps.MapTypeId.ROADMAP // 지도종류
							}; 

						// 지도를 생성한다 
						var map = new daum.maps.Map(mapContainer, mapOption); 

						// 지형도 타일 이미지 추가
						map.addOverlayMapTypeId(daum.maps.MapTypeId.TERRAIN); 

						// 지도 타입 변경 컨트롤을 생성한다
						var mapTypeControl = new daum.maps.MapTypeControl();

						// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
						map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);	

						// 지도에 확대 축소 컨트롤을 생성한다
						var zoomControl = new daum.maps.ZoomControl();

						// 지도의 우측에 확대 축소 컨트롤을 추가한다
						map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

						// 지도에 마커를 생성하고 표시한다
						var marker = new daum.maps.Marker({
							position: new daum.maps.LatLng(y, x), // 마커의 좌표
							map: map // 마커를 표시할 지도 객체
						});

						// 마커 위에 표시할 인포윈도우를 생성한다
						var infowindow = new daum.maps.InfoWindow({
							content : '<div style="padding:5px;">'+title+
							'<br><a href="http://map.daum.net/link/to/'+title+','+y+','+x+'" style="color:blue" target="_blank">길찾기</a></div>' // 인포윈도우에 표시할 내용
						});

						// 인포윈도우를 지도에 표시한다
						infowindow.open(map, marker);