<div class="tab-pane fade" id="<?=$id_tab?>">
    <h4 class="modal-title">
            <b><?=$sub_title?> DOCUMENTOS</b>
    </h4>
    <div class="row">
        <div class="col-md-12">
            <form id="novo_documento" class="smart-form" enctype="multipart/form-data">
                <input type="hidden" name="id_dominio" value="<?= $id_dominio_hidden ?>">
                <input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
                <fieldset>
                    <div class="row">
                        <section class="col col-5">
                            <label class="label">TIPO DE DOCUMENTO</label>
                            <label class="select">
                                <select class="input-xs" id="id_tipo_documento" name="id_tipo_documento" required>
                                    <option></option>
                                    <?php
                                        foreach ($tipos_documento as $td) {
                                            $id_tipo_documento = $td->getId_tipo_documento();
                                            $tipo_documento	   = $td->getNm_tipo_documento();
                                            $possui_validade   = $td->getPossui_validade();
                                    ?>
                                    <option value="<?php echo $id_tipo_documento?>" possui_validade="<?php echo $possui_validade?>"><?php echo $tipo_documento?></option>
                                    <?php
                                        }
                                    ?>
                                </select> <i></i>
                            </label>
                            <div id="input_validade" style="display: none;">
                                <label class="label">VALIDADE DO DOCUMENTO</label>
                                <label class="input">
                                    <input type="text" class="data_validade" name="validade" placeholder="99/99/9999">
                                </label>
                            </div>
                            <input type="file" name="documento" required style="margin-top: 10px;">
                        </section>
                        <section class="col col-6">
                            <label class="label">OBSERVAÇÃO</label>
                            <label class="textarea" style="width: 100%;">
                                <textarea rows="5" class="custom-scroll" name="observacao"></textarea>
                            </label>
                        </section>
                        <section class="col col-1">
                            <br><br>
                            <button type="submit" class="btn btn-primary btn-xs">Inserir</button>
                        </section>
                    </div>
                </fieldset>
            </form>
            <table class="table table-bordered">
                <thead>
                    <th colspan="4">Documentos inseridos</th>
                </thead>
                <tbody id="docs">
                    <?php
                        foreach ($documentos as $dc) {
                            $id_documento  = $dc->getId_documento();
                            $nm_documento  = $dc->getNm_documento();
                            $tp_documento  = $dc->getTipo_documento();
                            $data_validade = $dc->getData_validade();
                            $observacao    = $dc->getObservacao();
                            $download      = $dc->getDownload();
                    ?>
                    <tr id="doc<?php echo $id_documento?>">
                        <td>
                            <a href='documents/<?php echo $download?>' download="<?php echo $nm_documento?>">
                                <?php echo $nm_documento?>
                            </a>
                        </td>
                        <td><?php echo $tp_documento?></td>
                        <td align="center"><?php echo $data_validade?></td>
                        <!-- <td><?php echo $observacao?></td> -->
                        <td align="center">
                            <a href='#' onclick='removerDoc(<?php echo $id_documento?>)'>x</a>
                        </td>
                    </tr>
                    <?php } ?>
                </tbody>
            </table>
        </div>
    </div>
</div>