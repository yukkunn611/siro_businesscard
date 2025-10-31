$(document).ready(function() {
    const container = $('#card-container');
    const cardImage = $('#cardImage');
    const closeBtn = $('#closeBtn');

    // メッセージリスナー
    window.addEventListener('message', function(event) {
        const data = event.data;

        switch(data.action) {
            case 'showCard':
                showCard(data.image, data.name);
                break;
            case 'hideCard':
                hideCard();
                break;
        }
    });

    // 名刺を表示
    function showCard(imagePath, cardName) {
        // 画像パスを正しいNUI形式に変換
        const resourceName = GetParentResourceName();
        const fullPath = `nui://${resourceName}/${imagePath}`;
        
        cardImage.attr('src', fullPath);
        cardImage.attr('alt', cardName || 'Business Card');
        
        container.removeClass('hidden');
    }

    // 名刺を非表示
    function hideCard() {
        container.addClass('hidden');
        cardImage.attr('src', '');
    }

    // 閉じるボタンクリック
    closeBtn.on('click', function() {
        $.post(`https://${GetParentResourceName()}/closeCard`, JSON.stringify({}));
        hideCard();
    });

    // オーバーレイクリックで閉じる
    $('.card-overlay').on('click', function(e) {
        if (e.target === this) {
            $.post(`https://${GetParentResourceName()}/closeCard`, JSON.stringify({}));
            hideCard();
        }
    });

    // リソース名を取得するヘルパー関数
    function GetParentResourceName() {
        let num = 0;
        let resourceName = '';
        while (resourceName === '' && num < 5) {
            resourceName = (new Error()).stack.split('\n')[2 + num].match(/https:\/\/(.+?)\//)[1];
            num++;
        }
        return resourceName || 'businesscard';
    }
});
