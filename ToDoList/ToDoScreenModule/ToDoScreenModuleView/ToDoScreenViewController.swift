import UIKit
final class ToDoScreenViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var presenter: ToDoScreenModulePresenterProtocol
    private var priorityNames = [toDoScreenResources.lowText, toDoScreenResources.midText, toDoScreenResources.highText]
    
    // MARK: - UI components
    
    private lazy var createButton: UIButton = {
        var createButton = UIButton()
        createButton.setTitle(toDoScreenResources.createText, for: .normal)
        createButton.setTitleColor(UIColor.systemBlue, for: .normal)
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return createButton
    }()
    
    private lazy var deleteButton: UIButton = {
        var deleteButton = UIButton()
        deleteButton.setTitle(toDoScreenResources.deleteText, for: .normal)
        deleteButton.setTitleColor(UIColor.systemRed, for: .normal)
        deleteButton.isHidden = true
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return deleteButton
    }()
    
    private lazy var backButton: UIButton = {
        var backButton = UIButton()
        backButton.setImage(UIImage.chevronLeftImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return backButton
    }()
    
    private lazy var nameTextView: UITextView = {
        var nameTextView = UITextView()
        nameTextView.font = .nameTextFont
        nameTextView.delegate = self
        nameTextView.isScrollEnabled = false
        nameTextView.isEditable = true
        return nameTextView
    }()
    
    private lazy var placeholderNameLabel: UILabel = {
        let label = UILabel()
        label.text = toDoScreenResources.addToDo
        label.font = .nameTextFont
        label.textColor = .gray
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        var detailsTextField = UITextView()
        detailsTextField.font = .detailsFont
        detailsTextField.delegate = self
        detailsTextField.isScrollEnabled = false
        detailsTextField.isEditable = true
        return detailsTextField
    }()
    
    private lazy var placeholderDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = toDoScreenResources.addDescription
        label.font = .detailsFont
        label.textColor = .gray
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .clear
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.layer.cornerRadius = 16
        datePicker.layer.masksToBounds = true
        datePicker.overrideUserInterfaceStyle = .light
        datePicker.locale = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(actionForTapDatePicker), for: .valueChanged)
        presenter.dateEdited(date: datePicker.date)
        return datePicker
    }()
    
    private lazy var priorityCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var priorityCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        priorityCollectionView.register(PriorityCollectionViewCell.self, forCellWithReuseIdentifier: toDoScreenResources.priorityCellReuseIdentifierText)
        priorityCollectionView.allowsMultipleSelection = false
        priorityCollectionView.delegate = self
        priorityCollectionView.dataSource = self
        return priorityCollectionView
    }()
    
    // MARK: - Initializers
    
    init(presenter: ToDoScreenModulePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Resources.fatalErrorText)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.viewDidLoad()
        setupConstraints()
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        [backButton, createButton, nameTextView, descriptionTextView, datePicker, priorityCollectionView, placeholderNameLabel, placeholderDescriptionLabel, deleteButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            nameTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            nameTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            placeholderNameLabel.leadingAnchor.constraint(equalTo: nameTextView.leadingAnchor, constant: 5),
            placeholderNameLabel.topAnchor.constraint(equalTo: nameTextView.topAnchor, constant: 8),
            
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            placeholderDescriptionLabel.leadingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: 5),
            placeholderDescriptionLabel.topAnchor.constraint(equalTo: descriptionTextView.topAnchor, constant: 6),
            
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePicker.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            
            priorityCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priorityCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            priorityCollectionView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            priorityCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Objc methods
    
    @objc private func backButtonTapped() {
        presenter.switchToMainScreen()
    }
    
    @objc private func actionForTapDatePicker() {
        presenter.dateEdited(date: datePicker.date)
    }
    
    @objc private func createButtonTapped() {
        presenter.tryToCreate()
    }
    
    @objc private func deleteButtonTapped() {
        presenter.deleteToDo()
    }
    
}

    // MARK: - UITextViewDelegate

extension ToDoScreenViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case nameTextView:
            placeholderNameLabel.isHidden = !textView.text.isEmpty
            presenter.nameEdited(name: textView.text)
        case descriptionTextView:
            placeholderDescriptionLabel.isHidden = !textView.text.isEmpty
            presenter.descriptionEdited(description: textView.text)
        default: break
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView {
        case nameTextView:
            placeholderNameLabel.isHidden = !textView.text.isEmpty
        case descriptionTextView:
            placeholderDescriptionLabel.isHidden = !textView.text.isEmpty
        default: break
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView {
        case nameTextView:
            placeholderNameLabel.isHidden = !textView.text.isEmpty
            presenter.nameEdited(name: textView.text)
        case descriptionTextView:
            placeholderDescriptionLabel.isHidden = !textView.text.isEmpty
            presenter.descriptionEdited(description: textView.text)
        default: break
        }
    }
}

    // MARK: - UICollectionViewDataSource

extension ToDoScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = priorityCollectionView.dequeueReusableCell(withReuseIdentifier: toDoScreenResources.priorityCellReuseIdentifierText, for: indexPath) as? PriorityCollectionViewCell else {
            return UICollectionViewCell()
        }
        switch priorityNames[indexPath.row] {
        case toDoScreenResources.lowText:
            cell.lowCell()
        case toDoScreenResources.midText:
            cell.midCell()
        case toDoScreenResources.highText:
            cell.highCell()
        default: break
        }
        return cell
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension ToDoScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 3
        return CGSize(width: width, height: 50)
    }
}

    // MARK: - UICollectionViewDelegate

extension ToDoScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as? PriorityCollectionViewCell
        cell?.cellSelected()
        switch indexPath.row {
        case 0: presenter.priorityEdited(priority: toDoScreenResources.lowText)
        case 1: presenter.priorityEdited(priority: toDoScreenResources.midText)
        case 2: presenter.priorityEdited(priority: toDoScreenResources.highText)
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? PriorityCollectionViewCell
        cell?.cellDeselected()
    }
}

    // MARK: - ToDoScreenViewControllerProtocol

extension ToDoScreenViewController: ToDoScreenViewControllerProtocol {
    func setupWithToDo(toDo: ToDo) {
        createButton.setTitle(toDoScreenResources.saveText, for: .normal)
        nameTextView.text = toDo.name
        presenter.nameEdited(name: nameTextView.text)
        if let description = toDo.descriptioin {
            descriptionTextView.text = description
            presenter.descriptionEdited(description: description)
        }
        if let date = toDo.date {
            datePicker.date = date
            presenter.dateEdited(date: date)
        }
        if let priority = toDo.priority {
            switch priority {
            case toDoScreenResources.lowText: collectionView(priorityCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
            case toDoScreenResources.midText: collectionView(priorityCollectionView, didSelectItemAt: IndexPath(item: 1, section: 0))
            case toDoScreenResources.highText: collectionView(priorityCollectionView, didSelectItemAt: IndexPath(item: 2, section: 0))
            default: break
            }
            presenter.priorityEdited(priority: priority)
        }
        deleteButton.isHidden = false
        placeholderNameLabel.isHidden = !nameTextView.text.isEmpty
        placeholderDescriptionLabel.isHidden = !descriptionTextView.text.isEmpty
    }
    
    func showAlert() {
        let alertController = UIAlertController(
            title: toDoScreenResources.alertTitleText,
            message: toDoScreenResources.alertMessageText,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: toDoScreenResources.okText, style: .default) { _ in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
