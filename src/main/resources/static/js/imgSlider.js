// banner slider
        $(function () {
            $('.fg-banner').slick({
                autoplay: true,
                autoplaySpeed: 5000,
                dots: true,
                slidesToShow: 1,
                arrows: false
            })
        });

        // item2 slider
        $(function () {
            $('.item2__slider').slick({
                autoplay: true,
                autoplaySpeed: 2000,
                dots: true,
                centerMode: true,
                centerPadding: '60px',
                slidesToShow: 3,
                responsive: [
                    {
                        breakpoint: 768,
                        settings: {
                            arrows: false,
                            centerMode: true,
                            centerPadding: '40px',
                            slidesToShow: 2
                        }
                    },
                    {
                        breakpoint: 480,
                        settings: {
                            arrows: false,
                            centerMode: true,
                            centerPadding: '40px',
                            slidesToShow: 1
                        }
                    }
                ]
            })
        });