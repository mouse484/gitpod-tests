# athrill コピー元イメージ
FROM mikoto2000/athrill:rh850f1x-latest AS athrill

# COPY の失敗対策ワークアラウンド
# See:https://qiita.com/yktsr/items/1e31b4bf77c16b122588 
RUN chown root:root /usr/local/bin/athrill2 /usr/local/bin/athrill-run
RUN chown -R root:root /opt/athrill


# カーネルビルド環境構築済みイメージ
FROM mikoto2000/toppers-kernel-build-kit:athrill-gcc-latest

# athrill バイナリコピー元イメージからバイナリをコピー
COPY --from=athrill --chown=root:root \
    /usr/local/bin/athrill2 \
    /usr/local/bin
COPY --from=athrill --chown=root:root \
    /usr/local/bin/athrill-run \
    /usr/local/bin

# athrill コピー元イメージからサンプル設定ファイルをコピー
COPY --from=athrill --chown=root:root \
    /opt/athrill \
    /opt/athrill    

USER gitpod

ENV PATH="/usr/local/athrill-gcc/bin/:${PATH}" \
    LD_LIBRARY_PATH="/usr/local/athrill-gcc:/usr/local/athrill-gcc/lib:${LD_LIBRARY_PATH}"

